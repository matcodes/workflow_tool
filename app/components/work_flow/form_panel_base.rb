module WorkFlow
  module FormPanelBase
    def self.included(klass)
      klass.class_eval do

        js_method :init_component, <<-JS
          function() {
            this.callParent();
              Ext.each(this.query('combo'), function(cmp) {
                cmp.store.on('load', function(self, params) {
                  if (cmp.defaultIfSingleItem == undefined || cmp.defaultIfSingleItem == true) {
                    var modelName = cmp.parentId + "_" + cmp.name;
                    if (self.getCount() == 2 && self.getAt(0).get("field1") == null) {
                        this.setValue(self.getAt(1));
                        this.fireEvent('select', this);
                    }
                  }
                }, cmp);
              });
          }
        JS

        def get_combobox_options_endpoint(params)
          if self.respond_to?("#{params[:column]}_combobox_options".to_sym)
            self.send("#{params[:column]}_combobox_options".to_sym, params)
          else
            super
          end
        end

        def normalize_fields(items)
          itms = super
          itms.each_with_index do |item, index|
            if item[:xtype] == :datefield
              item[:format] = "m/d/Y"
            elsif item[:xtype] == :xdatetime
              item[:dateFormat] = "m/d/Y"
              item[:timeFormat] = "H:i"
            end
            itms[index] = item
          end
          itms
        end

        js_method :reset_combo, <<-JS
          function(item_ids) {
            item_ids = Ext.isArray(item_ids) ? item_ids : [item_ids]
            Ext.each(item_ids, function(item_id) {
              var cmp = this.query("combo#" + item_id)[0];
              cmp.store.removeAll();
              cmp.reset();
              console.log("resetting- " + item_id);
            }, this);
          }
        JS

        js_method :refresh_combo_store, <<-JS
          function(item_ids) {
            item_ids = Ext.isArray(item_ids) ? item_ids : [item_ids]
            Ext.each(item_ids, function(item_id) {
              var cmp = this.query("combo#" + item_id)[0];
              cmp.reset();
              cmp.store.reload();
              console.log("Reloading Store of - " + item_id);
            }, this);
          }
        JS

        js_method :on_apply, <<-JS
        function() {
          if (this.fireEvent('apply', this)) {
            var values = this.getForm().getValues();
            for (var fieldName in values) {
              var field = this.getForm().findField(fieldName);

              // TODO: move the following checks to the server side (through the :display_only option)

              // do not submit values from disabled fields
              if (!field || field.disabled) {
                delete values[fieldName];
              }

              // do not submit values from read-only association fields
              if (field
                && field.name.indexOf("__") !== -1
                && (field.readOnly || !field.isXType('combobox'))
                && (!field.nestedAttribute) // except for "nested attributes"
              ) {
                delete values[fieldName];
              }

              // do not submit values from displayfields
              if (field.isXType('displayfield')) {
                delete values[fieldName];
              }

              // do not submit displayOnly fields
              if (field.displayOnly) {
                delete values[fieldName];
              }
            }
            // WIP: commented out on 2011-05-11 because of fatal errors
            // apply mask
            // if (!this.applyMaskCmp) this.applyMaskCmp = new Ext.LoadMask(this.bwrap, this.applyMask);
            // this.applyMaskCmp.show();

            // We must use a different approach when the form is multipart, as we can't use the endpoint
            if (this.fileUpload) {
              this.getForm().submit({ // normal submit
                url: this.endpointUrl("netzke_submit"),
                params: {
                  data: Ext.encode(values) // here are the correct values that may be different from display values
                },
                failure: function(form, action){
                    try {
                        var respObj = Ext.decode(action.response.responseText);
                        delete respObj.success;
                        this.bulkExecute(respObj);
                        this.fireEvent('submitsuccess');
                    }
                    catch(e) {
                        Ext.Msg.alert('File upload error', action.response.responseText);
                    }
                  if (this.applyMaskCmp) this.applyMaskCmp.hide();
                },
                success: function(form, action) {
                  try {
                    var respObj = Ext.decode(action.response.responseText);
                    delete respObj.success;
                    this.bulkExecute(respObj);
                    this.fireEvent('submitsuccess');
                  }
                  catch(e) {
                    Ext.Msg.alert('File upload error', action.response.responseText);
                  }
                  if (this.applyMaskCmp) this.applyMaskCmp.hide();
                },
                scope: this
              });
            } else {
              console.log(Ext.encode(values));
              this.netzkeSubmit(Ext.apply((this.baseParams || {}), {data:Ext.encode(values)}), function(success){
                console.log(success);
                // For visit form success value is returning object, so temporarily we checking success == true

                if (success == true) {
                  if (this.mode == "lockable") this.setReadonlyMode(true);
                  if (this.notifyOnSave == undefined || this.notifyOnSave == true) {
                    Ext.MessageBox.alert("Success", "Record saved successfully.", function(){
                      this.fireEvent("submitsuccess");
                    }, this);
                  } else {
                    this.fireEvent("submitsuccess");
                  }
                };
                if (this.applyMaskCmp) this.applyMaskCmp.hide();
              }, this);
            }
          }
          this.fireEvent('afterApply', this);
        }
        JS

        js_method :set_form_values,<<-JS
          function(values){
            console.log("Form panel");
            var assocValues = values._meta.associationValues || {};
            for (var assocFieldName in assocValues) {

              var assocField = this.getForm().getFields().filter('name', assocFieldName).first();
              if (assocField.isXType('combobox')) {
                assocField.emptyText = assocField.emptyText || "---";
                // HACK: using private property 'store' here!
                assocField.store.loadData([[values[assocFieldName], assocValues[assocFieldName]]]);
                delete assocField.lastQuery; // force loading the store next time user clicks the trigger
              } else {
                assocField.setValue(assocValues[assocFieldName]);
                delete values[assocFieldName]; // we don't want this to be set once more below with setValues()
              }
            }

            // PRAVEEN HACK HACK MAJOR HACK
            // Extjs decided that it should behave differently in parsing date between grid and form
            // After a patch for grid related date formatting issue of adding 00:00:00 the form date
            // parsing is broken. So, removing the added 00:00:00 only at the form level
            // UGLY UGLY ISSUE. PREFER TO REVISIT
            for (var fieldName in values) {
              if (fieldName != '_meta') {
                var field = this.getForm().getFields().filter('name', fieldName).first();
                if (field.isXType('datefield')) {
                  values[fieldName] = values[fieldName].substring(0, 10);
                } else if(field.isXType('xdatetime')){
                  values[fieldName] = Ext.util.Format.date(values[fieldName], "m/d/Y H:i")
                } else if(field.isXType('timefield')){
                  values[fieldName] = values[fieldName].substring(11, 19);
                }

              }
            }
            console.log(values);
            this.getForm().setValues(values);
          }
        JS
      end


    end
  end
end
