module WorkFlow
  class FormPanel < Netzke::Basepack::FormPanel
    include NetzkeBase
    include FormPanelBase
    
    def configure_bbar(c)
      c[:bbar] = ["->", :apply.action] if c[:bbar].nil? && !c[:read_only]
    end

  end
end
