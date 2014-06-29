class CompanyUserForm < WorkFlow::FormPanel

  def configuration
    s = super
    s.merge(
       model: "CompanyUser",
       items: [
           {name: :user__user_type, field_label: "Role Type", item_id: :user_type},
           {name: :user__full_name, field_label: "User", item_id: :user_name}
       ]
    )
  end
  
  def user__user_type_combobox_options(params)
    {:data => User::USER_TYPES_STORE}
  end
  
  def user__full_name_combobox_options(params)
    values = []
		unless component_session[:user_type].nil?
			values = component_session[:user_type].constantize.all.collect{|u| [u.id, u.full_name]}
		end
		{:data => values}
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      var userType = this.down("#user_type");
      var userName = this.down("#user_name");
      userType.on("select", function(ele){
        this.selectUserType({user_type: ele.value});
      }, this);
    }
  JS

  endpoint :select_user_type do |params|
    component_session[:user_type] = params[:user_type]
    {:refresh_combo_store => :user_name}
  end

end
