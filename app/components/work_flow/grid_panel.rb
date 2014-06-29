module WorkFlow
  class GridPanel < Netzke::Basepack::GridPanel
    js_method :init_component, <<-JS
      function(){

        this.callParent();
      }
    JS

    def configuration
      super.merge({emptyText: 'No Records'})
    end

    def columns(options = {})
      cols = super
      cols
    end
  end
end