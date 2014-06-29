class AddMessage < WorkFlow::FormPanel

  def configuration
    s = super
    s.merge(
        model: "Conversation",
        title: "Send Message",
        items: [
            {name: :message, field_label: ""}
        ],
        strong_default_attrs: {order_id: s[:order_id]}
    )
  end

  action :apply, text: "Send", tooltip: "Send"

  js_method :on_apply,<<-JS
    function(){
      var values = this.getForm().getValues();
      this.createRecord({form_values: values},function(result){
        if(result){
          this.up("#conversation_explorer").down('#conversations_list').store.load();
          this.form.reset();
        }
      });
    }
  JS

  endpoint :create_record do  |params|
    result = Conversation.create!(params[:form_values].merge(config[:strong_default_attrs]))
    {set_result: result}
  end


end