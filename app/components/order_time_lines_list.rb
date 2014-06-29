class OrderTimeLinesList < WorkFlow::GridPanel

  def configuration
    s = super
    s.merge(
        model: "TimeLine",
        columns: [
            {name: :job, label: "Job", editable: false, getter: lambda{|r| TimeLine::TIME_LINE_JOBS["#{r.job}"]}},
            {name: :start_date, label: "Start Date"},
            {name: :end_date, label: "End Date"},
        ],
        scope: {:order_id => s[:order_id]}
    )
  end

  def default_bbar
    [:edit.action, :apply.action]
  end

  def default_context_menu
    []
  end

end