class CompaniesList < WorkFlow::GridPanel

  def configuration
    s = super
    s.merge(
      model: (s[:model].nil? ? "Company" : s[:model]),
      columns: [
          {name: :company_name, label: "Name", width: "20%"},
          {name: :company_code, label: "Code"}
      ]
    )
  end

  add_form_window_config title: "Add Company"
  edit_form_window_config title: "Edit Company"

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

end