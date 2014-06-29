class UserForm < WorkFlow::FormPanel

  def configuration
    s = super
    s.merge(
        model: "User",
        items: [
					{name: :user_type, field_label: "User Role", xtype: :combo, store: User::USER_TYPES_STORE},
					{name: :first_name, field_label: "First Name"},
					{name: :last_name, field_label: "Last Name"},
					{name: :email, field_label: "Email"},
					{name: :password, inputType: 'password', margin: "0 0 5px 0" },
				  {name: :password_confirmation, inputType: 'password', field_label: "Confirm Password"},
				  {name: :address_line1, field_label: "Address Line 1"},
				  {name: :address_line2, field_label: "Address Line 2"},
				  {name: :city, field_label: "City"},
				  {name: :state, field_label: "State"},
				  {name: :zip_code, field_label: "Zipe Code"},
				  {name: :phone_number, field_label: "Phone Number"},
        ]
    )
  end
     
end
