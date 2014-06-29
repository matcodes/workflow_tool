class Navigation < Netzke::Base

  js_base_class "Ext.tree.TreePanel"

  def configuration
    s = super
    s.merge(
                border: false,
                item_id: "navigation_container",
                split: true,
                tools: [:refresh],
                header: true,
                collapsible: true,
                title: "Admin Manager",
                layout: :fit,
                frame: true,
                width: 220,
                height: 150,
                margin: 0,
                rootVisivle: true,
                root: {
                    :text => "Navigation",
                    :expanded => true,
                    :children => tree_nodes
                },
            )
  end

  js_method :init_component, <<-JS
    function() {
      this.callParent();
      this.loadHomePageComponent({}, function(component){
        this.loadNetzkeComponent({name: component, container: this.up().up().down("#main_panel")});
      }, this);
      this.getView().on('itemclick', function(e,r,i){
        if (r.raw.component) {
          this.loadNetzkeComponent({name: r.raw.component, container: this.up().up().down("#main_panel"),
            params: {component_params: r.raw.params}});
        }
      }, this);
    }
  JS

  js_method :after_render, <<-JS
    function() {
      this.callParent();
      var tree = this;
      this.onRefresh = function() {
        tree.refreshTree({}, function(nodes) {
          this.setRootNode(nodes);
        });
      }
    }
  JS

  endpoint :refresh_tree do |params|
    {set_result: tree_nodes}
  end

  endpoint :load_home_page_component do |params|
    if session[:home_page_component]
      {set_result: session[:home_page_component].camelize}
    else
      {}
    end
  end

  def tree_nodes
    user_role = User.current.class.name
    user_role = case user_role
                  when 'SuperAdmin'
                    "SA"
                  when 'SalesPerson'
                    "SP"
                end
    settings = YAML::load(File.open("config/navigations/#{user_role}_pages.yml"))
    session[:home_page_component] = settings['default']
    pages = settings['pages']
    process_pages(pages)
  end

  def process_pages(pages)
    pages.collect do |page|
      page["icon"] = get_icon_path(page)
      if page_has_children?(page)
        page["expanded"] = true
        page["children"] = process_pages(page["children"])
      else
        page["leaf"] = true
      end
      page
    end
    pages
  end

  def page_has_children?(page)
    page.include?("children")
  end

  def get_icon_path(page)
    uri_to_icon(page["icon"])
  end

  component :orders_list, lazy_loading: true

  component :users_list, lazy_loading: true

  component :company_users_explorer, lazy_loading: true

end