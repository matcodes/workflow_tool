class ConversationsList < WorkFlow::GridPanel

  def configuration
    s = super
    s.merge(
        model: "Conversation",
        item_id: :conversations_list,
        header: false,
        columns: [
            {name: :sender__full_name, label: "Sender", editable: false},
            {name: :conversation_date, label: "Date", editable: false},
            {name: :message, label: "Message", editable: false, tdCls: 'wrap', flex: 1},
        ],
        scope: {:order_id => s[:order_id]}
    )
  end

  def default_bbar
    []
  end

  def default_context_menu
    []
  end

end