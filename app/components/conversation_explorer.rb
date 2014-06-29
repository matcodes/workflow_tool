class ConversationExplorer < Netzke::Basepack::Panel

  def configuration
    s = super
    s.merge(
        layout: :border,
        item_id: :conversation_explorer,
        header: false,
        items: [
            :conversations_list.component,
            :add_message.component
        ]
    )
  end

  component :conversations_list do
    {
        class_name: "ConversationsList",
        order_id: config[:order_id],
        region: :center
    }
  end

  component :add_message do
    {
        class_name: "AddMessage",
        order_id: config[:order_id],
        region: :south
    }
  end



end