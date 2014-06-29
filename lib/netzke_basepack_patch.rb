require 'netzke/basepack/data_adapters/active_record_adapter'
module Netzke::Basepack::DataAdapters
  class ActiveRecordAdapter < AbstractAdapter
    def get_assoc_property_type assoc_name, prop_name
      if prop_name && assoc=@model_class.reflect_on_association(assoc_name)
        return :netzkeremotecombo if assoc.options and assoc.options.keys.include? :polymorphic
        assoc_column = assoc.klass.columns_hash[prop_name.to_s]
        assoc_column.try(:type)
      end
    end
  end
end
require 'netzke/active_record/attributes'

module Netzke::ActiveRecord::Attributes
  # Fetches the value specified by an (association) attribute
  # If +through_association+ is true, get the value of the association by provided method, *not* the associated record's id
  # E.g., author__name with through_association set to true may return "Vladimir Nabokov", while with through_association set to false, it'll return author_id for the current record
  def value_for_attribute(a, through_association = false)
    v = if a[:getter]
          a[:getter].call(self)
        elsif respond_to?("#{a[:name]}")
          result = send("#{a[:name]}")
          # a work-around for to_json not taking the current timezone into account
          type = self.class.columns_hash[a[:name]].instance_variable_get(:@type)
          if type == :date
            result = result.to_datetime.to_s(:db) if result
          else
            result
          end
        elsif is_association_attr?(a)
          split = a[:name].to_s.split(/\.|__/)
          assoc = self.class.reflect_on_association(split.first.to_sym)
          if through_association
            split.inject(self) do |r,m| # TODO: do we really need to descend deeper than 1 level?
              if r.respond_to?(m)
                r.send(m)
              else
                logger.debug "Netzke::Basepack: Wrong attribute name: #{a[:name]}" unless r.nil?
                nil
              end
            end
          elsif assoc and assoc.macro == :belongs_to and assoc.options.keys.include?(:polymorphic)
            obj = send(split.first.to_sym)
            obj ? "#{obj.class.name}_#{obj.id}" : obj
          else
            self.send("#{assoc.options[:foreign_key] || assoc.name.to_s.foreign_key}") if assoc
          end
        end

    # a work-around for to_json not taking the current timezone into account when serializing ActiveSupport::TimeWithZone
    v = v.to_datetime.to_s(:db) if [ActiveSupport::TimeWithZone].include?(v.class)
    
    v
  end

  # Assigns new value to an (association) attribute
  def set_value_for_attribute(a, v)
    v = v.to_time_in_current_zone if v.is_a?(Date) # convert Date to Time
    if a[:xtype] and a[:xtype] == :datefield and not v.nil?
      month, day, year = v.split('/')
      v = Date.new(year.to_i, month.to_i, day.to_i)
    elsif a[:xtype] and a[:xtype] == :xdatetime
      v = Time.strptime(v, "%m/%d/%Y %H:%M")
    end

    if a[:setter]
      a[:setter].call(self, v)
    elsif respond_to?("#{a[:name]}=")
      send("#{a[:name]}=", v)
    elsif is_association_attr?(a)
      split = a[:name].to_s.split(/\.|__/)
      if a[:nested_attribute]
        # We want:
        #     set_value_for_attribute({:name => :assoc_1__assoc_2__method, :nested_attribute => true}, 100)
        # =>
        #     self.assoc_1.assoc_2.method = 100
        split.inject(self) { |r,m| m == split.last ? (r && r.send("#{m}=", v) && r.save) : r.send(m) }
      else
        if split.size == 2
          # search for association and assign it to self
          assoc = self.class.reflect_on_association(split.first.to_sym)
          assoc_method = split.last
          if assoc
            if assoc.macro == :has_one
              assoc_instance = self.send(assoc.name)
              if assoc_instance
                assoc_instance.send("#{assoc_method}=", v)
                assoc_instance.save # what should we do when this fails?..
              else
                # what should we do in this case?
              end
            elsif assoc.macro == :belongs_to and assoc.options.keys.include?(:polymorphic)
              polymorphic_assoc_class_name, polymorphic_assoc_id = v.split("_")
              obj = polymorphic_assoc_class_name.constantize.find(polymorphic_assoc_id)
              self.send("#{split.first.to_sym}=", obj)
            else
              self.send("#{assoc.options[:foreign_key] || assoc.name.to_s.foreign_key}=", v)
            end
          else
            logger.debug "Netzke::Basepack: Association #{assoc} is not known for class #{self.class.name}"
          end
        else
          logger.debug "Netzke::Basepack: Wrong attribute name: #{a[:name]}"
        end
      end
    end
  end

end

require 'netzke/basepack/panel'
class Netzke::Basepack::Panel
    alias_method :original_initialize, :initialize
    def initialize(conf = {}, parent = nil)
      @form_panel = nil
      unless self.is_a?(Netzke::Basepack::FormPanel)
        current_panel = parent
        while (@form_panel.nil? and current_panel.nil? == false)
          if current_panel.is_a?(Netzke::Basepack::FormPanel)
            @form_panel = current_panel
          else
            current_panel = current_panel.instance_variable_get("@parent")
          end
        end
      end
      original_initialize conf, parent
      @form_panel.send(:normalize_fields, items) if @form_panel
    end
end
