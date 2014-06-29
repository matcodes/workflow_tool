class OrdersList < WorkFlow::GridPanel

  def configuration
    s = super
    s.merge(
        model: "Order",
        title: "Orders",
        columns: [
            {name: :company__company_name, label: "Company"},
            {name: :sales_person__full_name, label: "Sales Person"},
            {name: :site_url, label: "Site URL"},
            {name: :site_type, label: "Site Type", getter: lambda{|r| Order::SITE_TYPE_MAP["#{r.site_type}"]}},
            {name: :no_of_pages, label: "# of pages"},
        ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action, :view_order.action, :add_time_line.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  add_form_config class_name: "OrderForm"
  add_form_window_config width: "90%", height: "90%"
  edit_form_config class_name: "OrderForm"
  edit_form_window_config width: "90%", height: "90%"

  action :view_order, text: "View Order", icon: :pencil, disabled: true
  action :add_time_line, text: "Add Time Lines", icon: :chart_curve, disabled: true

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.resetSessionContext();
      this.on('itemclick', function(view, record){
        this.selectOrderId({order_id: record.get("id")});
        this.actions.viewOrder.setDisabled(this.getSelectionModel().getCount() != 1);
        this.actions.addTimeLine.setDisabled(this.getSelectionModel().getCount() != 1);
      }, this);
    }
  JS

  endpoint :reset_session_context do |params|
    component_session[:order_id] = nil
  end

  endpoint :select_order_id do |params|
    component_session[:order_id] = params[:order_id]
  end

  js_method :on_view_order,<<-JS
    function(){
      if(this.getSelectionModel().getCount() == 1){
        var w = new Ext.window.Window({
          width: "40%",
          height: "80%",
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "Close",
              listeners: {
                click: function(){w.close();}
              }
            }
          ],
            title: "Order Details",
        });
        w.show();
        this.loadNetzkeComponent({name: "conversation_explorer", container:w, callback: function(w){
          w.show();
        }});
      } else{
        Ext.MessageBox.alert("Information", "Please select one <b>order</b> to view details.")
      }
    }
  JS

  js_method :on_add_time_line,<<-JS
    function(){
      if(this.getSelectionModel().getCount() == 1){
        var w = new Ext.window.Window({
          width: "40%",
          height: "80%",
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "Close",
              listeners: {
                click: function(){w.close();}
              }
            }
          ],
            title: "Order Details",
        });
        w.show();
        this.loadNetzkeComponent({name: "order_time_lines_list", container:w, callback: function(w){
          w.show();
        }});
      } else{
        Ext.MessageBox.alert("Information", "Please select one <b>order</b> to add time lines.")
      }
    }
  JS

  component :conversation_explorer do
    {
        class_name: "ConversationExplorer",
        order_id: component_session[:order_id]
    }
  end

  component :order_time_lines_list do
    {
        class_name: "OrderTimeLinesList",
        order_id: component_session[:order_id]
    }
  end



end