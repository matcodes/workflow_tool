module WorkFlow
  module NetzkeBase
    def self.included(klass)
      klass.class_eval {include ActionView::Helpers::JavaScriptHelper}
      klass.class_eval {include ActionView::Helpers::TagHelper}
      klass.class_eval {include ActionView::Helpers::UrlHelper}
    end
    def action_column(grid_component_name = nil)
      comp_name = grid_component_name || self.class.name.underscore
      {name: :actions, flex: 1, label: "", editable: false,
       :getter => lambda {|x| x.events_for_current_state.collect{|r|
         link_to_function(human_action_name(r), perform_event(comp_name, x, r))}.join(" | ")
       }
      }
    end

    def human_action_name(event)
      event.title
    end

    def perform_event(comp_name, record, event)
      "Ext.ComponentQuery.query('##{comp_name}')[0].performAction(#{record.id}, '#{event.name}');"
    end
  end
end
