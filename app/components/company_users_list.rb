class CompanyUsersList < Netzke::Basepack::GridPanel

  def configuration
    s = super
    s.merge(
        model: "CompanyUser",
        title: "Users",
        columns: [
            {name: :user__first_name, label: "First Name", editable: false},
            {name: :user__last_name, label: "Last Name", editable: false},
            {name: :user__user_role, label: "Role"},
            {name: :user__email, label: "Email", editable: false},
            {name: :user__phone_number, label: "Phone Number", editable: false},
        ],
        strong_default_attrs: s[:strong_default_attrs]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  add_form_config class_name: "CompanyUserForm"
  add_form_window_config title: "Add User"
  edit_form_config class_name: "CompanyUserForm"
  edit_form_window_config title: "Edit User"

end
