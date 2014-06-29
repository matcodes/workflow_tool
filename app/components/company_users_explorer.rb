class CompanyUsersExplorer < Netzke::Basepack::Panel

  def configuration
    s = super
    s.merge(
        header: false,
        layout: :border,
        items: [
            :companies_list.component,
            :users_list.component,
        ]
    )
  end

  component :companies_list do
    {
        class_name: "CompaniesList",
        model: "WebsiteCompany",
        item_id: :companies_list,
        title: "Companies",
        region: :center,
        border: false
    }
  end

  component :users_list do
    {
        class_name: "CompanyUsersList",
        region: :south,
        border: false,
        item_id: :users_list,
        height: 200,
        strong_default_attrs: {company_id: component_session[:company_id]},
        scope: {company_id: component_session[:company_id]}
    }
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.resetSessionContext();
      this.down("#companies_list").on('itemclick', function(view, record){
        this.setCompanyId({company_id: record.get("id")}, function(result){
          if(result)
            this.down("#users_list").store.load();
        }, this);
      }, this);
    }
  JS

  endpoint :reset_session_context do |params|
    component_session[:company_id] = nil
  end

  endpoint :set_company_id do |params|
    component_session[:company_id] = params[:company_id]
    {set_result: true}
  end
end
