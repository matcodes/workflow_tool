class OrderForm < WorkFlow::FormPanel

  def configuration
    s = super
    s.merge(
        model: "Order",
        layout: :border,
        autoScroll: false,
        items: [
            {
                header: false,
                border: false,
                region: :north,
                items: [
                    {
                        header: false,
                        xtype: :fieldset,
                        items: [
                            {
                                margin: 5,
                                header: false,
                                border: false,
                                items: [
                                    {xtype: :label, text: "Please fill out the following fields and submit. You will receive an email confirmation when the order is received."},
                                ]
                            },{
                                header: false,
                                border: false,
                                layout: :hbox,
                                items: [
                                    {name: :sales_person__full_name, field_label: "Sales Representative", labelAlign: :right},
                                    {name: :company__company_name, field_label: "Company", labelAlign: :right}
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                region: :center,
                border: false,
                xtype: :tabpanel,
                header: false,
                items: [
                    {
                        title: "Site Details",
                        height: 500,
                        autoScroll: true,
                        items: [
                            {
                                xtype: :fieldset,
                                title: "URL",
                                margin: 5,
                                layout: :hbox,
                                items: [
                                    {
                                        name: :purchased_url,
                                        field_label: "What is the URL to be purchased",
                                        labelAlign: :top,
                                        xtype: :textfield,
                                        flex: 1,
                                        margin: 5
                                    },
                                    {
                                        name: :transferred_url,
                                        field_label: "If URL is a transfer, what is the URL to be transferred",
                                        labelAlign: :top,
                                        xtype: :textfield,
                                        flex: 1,
                                        margin: 5
                                    }
                                ]
                            },
                            {
                                xtype: :fieldset,
                                title: "Custom/Standard",
                                margin: 5,
                                layout: :vbox,
                                items: [
                                    {
                                        header: false,
                                        border: false,
                                        layout: :hbox,
                                        margin: 5,
                                        items: [
                                            {
                                                name: :site_type,
                                                field_label: "Custom",
                                                labelAlign: :right,
                                                inputValue: 'C',
                                                xtype: :radiofield
                                            },
                                            {
                                                name: :site_type,
                                                field_label: "Standard",
                                                labelAlign: :right,
                                                inputValue: 'S',
                                                xtype: :radiofield
                                            }
                                        ]
                                    },
                                    {
                                        header: false,
                                        border: false,
                                        layout: :vbox,
                                        margin: 5,
                                        items: [
                                            {
                                                xtype: 'radiogroup',
                                                labelWidth: 300,
                                                fieldLabel: "If Custom, does the client want a consultative call to discuss design and or content?",
                                                labelAlign: 'top',
                                                layout: :hbox,
                                                items: [
                                                    {
                                                        xtype: 'radiofield',
                                                        name: 'client_call_to_discuss',
                                                        boxLabel: 'Yes',
                                                        field_label: "",
                                                        width: 100,
                                                        margin: 5,
                                                        inputValue: "Y"
                                                    },
                                                    {
                                                        xtype: 'radiofield',
                                                        margin: 5,
                                                        width: 100,
                                                        field_label: "",
                                                        name: 'client_call_to_discuss',
                                                        boxLabel: 'No',
                                                        inputValue: "N"
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: :label,
                                                text: "What time would you like to schedule the call, please provide date and a 2 hour
                                        call window (we will do our best to accommodate and will contact you if there is a conflict)?"
                                            },
                                            {
                                                header: false,
                                                border: false,
                                                margin: 5,
                                                layout: :hbox,
                                                items: [
                                                    {
                                                        xtype: :datefield,
                                                        field_label: "Schedule Date",
                                                        name: :client_call_schedule_date,
                                                        labelAlign: :right
                                                    },
                                                    {
                                                        xtype: :timefield,
                                                        field_label: "Time 1",
                                                        name: :client_call_schedule_time1,
                                                        labelAlign: :right
                                                    },
                                                    {
                                                        xtype: :timefield,
                                                        field_label: "Time 2",
                                                        name: :client_call_schedule_time2,
                                                        labelAlign: :right
                                                    }
                                                ]
                                            },
                                            {
                                                header: false,
                                                border: false,
                                                margin: 5,
                                                layout: :hbox,
                                                items: [
                                                    {
                                                        xtype: 'radiogroup',
                                                        labelWidth: 300,
                                                        fieldLabel: "Do not auto publish after revision process",
                                                        labelAlign: 'top',
                                                        margin: '0 10 0 0',
                                                        layout: :hbox,
                                                        items: [
                                                            {
                                                                xtype: 'radiofield',
                                                                name: 'auto_publish',
                                                                width: 100,
                                                                field_label: "",
                                                                boxLabel: 'Yes',
                                                                margin: 5,
                                                                inputValue: "Y"
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                width: 100,
                                                                margin: 5,
                                                                field_label: "",
                                                                name: 'auto_publish',
                                                                boxLabel: 'No',
                                                                inputValue: "N"
                                                            }
                                                        ]
                                                    },{
                                                        xtype: 'radiogroup',
                                                        labelWidth: 300,
                                                        margin: '0 0 0 10',
                                                        fieldLabel: "With Mobile version?",
                                                        labelAlign: 'top',
                                                        layout: :hbox,
                                                        items: [
                                                            {
                                                                xtype: 'radiofield',
                                                                name: 'mobile_version_required',
                                                                width: 100,
                                                                field_label: "",
                                                                boxLabel: 'Yes',
                                                                margin: 5,
                                                                inputValue: "Y"
                                                            },
                                                            {
                                                                xtype: 'radiofield',
                                                                width: 100,
                                                                margin: 5,
                                                                name: 'mobile_version_required',
                                                                boxLabel: 'No',
                                                                inputValue: "N",
                                                                field_label: ""
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }

                                        ]
                                    }
                                ]
                            },
                            {
                                xtype: :fieldset,
                                title: "emails",
                                margin: 5,
                                layout: :hbox,
                                items:[
                                    {
                                        name: :email_for_contact_us,
                                        field_label: "Email address for the Contact Us form",
                                        labelAlign: :top,
                                        xtype: :textfield,
                                        flex: 1,
                                        margin: 5
                                    },
                                    {
                                        name: :additional_email_address,
                                        field_label: "Additional Email address to be created",
                                        labelAlign: :top,
                                        xtype: :textfield,
                                        flex: 1,
                                        margin: 5
                                    }
                                ]
                            }
                        ]
                    },{
                        title: "Other Information",
                        width: 500,
                        autoScroll: true,
                        items: [
                            {
                                xtype: :fieldset,
                                title: "Other Info",
                                layout: :hbox,
                                margin: 5,
                                items: [
                                    {
                                        flex: 1,
                                        header: false,
                                        border: false,
                                        layout: :vbox,
                                        items: [
                                            {
                                                xtype: 'radiogroup',
                                                labelWidth: 100,
                                                margin: '0 0 0 10',
                                                fieldLabel: "Google Map",
                                                labelAlign: 'top',
                                                layout: :hbox,
                                                items: [
                                                    {
                                                        xtype: 'radiofield',
                                                        name: 'google_map_required',
                                                        width: 100,
                                                        boxLabel: 'Yes',
                                                        field_label: "",
                                                        margin: 5,
                                                        inputValue: "Y"
                                                    },
                                                    {
                                                        xtype: 'radiofield',
                                                        width: 100,
                                                        margin: 5,
                                                        field_label: "",
                                                        name: 'google_map_required',
                                                        boxLabel: 'No',
                                                        inputValue: "N"
                                                    }
                                                ]
                                            },
                                            {
                                                name: :social_media_links,
                                                field_label: "Social Media Links",
                                                labelAlign: :top,
                                                margin: 5,
                                                width: 400,
                                                xtype: :textfield
                                            },
                                            {
                                                name: :no_of_pages,
                                                width: 200,
                                                field_label: "How many pages is the site",
                                                labelAlign: :top,
                                                xtype: :textfield
                                            },
                                            {
                                                xtype: :label,
                                                text: "What are the Page Titles",
                                            },
                                            {
                                                layout: :hbox,
                                                header: false,
                                                border: false,
                                                items: [
                                                    {
                                                        header: false,
                                                        border: false,
                                                        items: get_page_title_items(1)
                                                    },
                                                    {
                                                        header: false,
                                                        border: false,
                                                        items: get_page_title_items(6)
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        header: false,
                                        border: false,
                                        flex: 1,
                                        items: [
                                            {
                                                xtype: :textarea,
                                                field_label: "Please enter any additional comments on design as gathered from the customer",
                                                labelAlign: :top,
                                                name: :additional_comments,
                                                cols: 60,
                                                rows: 5
                                            },{
                                                xtype: :textarea,
                                                field_label: "Please enter any additional content or other comments regarding the site",
                                                labelAlign: :top,
                                                name: :additional_contents,
                                                cols: 60,
                                                rows: 5
                                            },{
                                                xtype: :textarea,
                                                field_label: "Keywords you wanted in your site (for Basic SEO)",
                                                labelAlign: :top,
                                                name: :keywords_wanted,
                                                cols: 60,
                                                rows: 5
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                    }
                ]  + get_page_items
            }

        ]
    )
  end

  component :order_details do
    {
        region: :center,
        border: false,
        xtype: :tabpanel,
        header: false,
        items: [
            {
                title: "Site Details",
                height: 500,
                autoScroll: true,
                items: [
                    {
                        xtype: :fieldset,
                        title: "URL",
                        margin: 5,
                        layout: :hbox,
                        items: [
                            {
                              name: :purchased_url,
                              field_label: "What is the URL to be purchased",
                              labelAlign: :top,
                              xtype: :textfield,
                              flex: 1,
                              margin: 5
                            },
                            {
                              name: :transferred_url,
                              field_label: "If URL is a transfer, what is the URL to be transferred",
                              labelAlign: :top,
                              xtype: :textfield,
                              flex: 1,
                              margin: 5
                            }
                        ]
                    },
                    {
                        xtype: :fieldset,
                        title: "Custom/Standard",
                        margin: 5,
                        layout: :vbox,
                        items: [
                            {
                              header: false,
                              border: false,
                              layout: :hbox,
                              margin: 5,
                              items: [
                                {
                                  name: :site_type,
                                  field_label: "Custom",
                                  labelAlign: :right,
                                  inputValue: 'C',
                                  xtype: :radiofield
                                },
                                {
                                  name: :site_type,
                                  field_label: "Standard",
                                  labelAlign: :right,
                                  inputValue: 'S',
                                  xtype: :radiofield
                                }
                              ]
                            },
                            {
                              header: false,
                              border: false,
                              layout: :vbox,
                              margin: 5,
                              items: [
                                {
                                  xtype: 'radiogroup',
                                  labelWidth: 300,
                                  fieldLabel: "If Custom, does the client want a consultative call to discuss design and or content?",
                                  labelAlign: 'top',
                                  layout: :hbox,
                                  items: [
                                    {
                                      xtype: 'radiofield',
                                      name: 'client_call_to_discuss',
                                      width: 100,
                                      boxLabel: 'Yes',
                                      margin: 5,
                                      inputValue: "Y"
                                    },
                                    {
                                      xtype: 'radiofield',
                                      width: 100,
                                      margin: 5,
                                      name: 'client_call_to_discuss',
                                      boxLabel: 'No',
                                      inputValue: "N"
                                    }
                                  ]
                                },
                                {
                                  xtype: :label,
                                  text: "What time would you like to schedule the call, please provide date and a 2 hour
                                        call window (we will do our best to accommodate and will contact you if there is a conflict)?"
                                },
                                {
                                  header: false,
                                  border: false,
                                  margin: 5,
                                  layout: :hbox,
                                  items: [
                                    {
                                      xtype: :datefield,
                                      field_label: "Schedule Date",
                                      name: :client_call_schedule_date,
                                      labelAlign: :right
                                    },
                                    {
                                      xtype: :timefield,
                                      field_label: "Time 1",
                                      name: :client_call_schedule_time1,
                                      labelAlign: :right
                                    },
                                    {
                                      xtype: :timefield,
                                      field_label: "Time 2",
                                      name: :client_call_schedule_time2,
                                      labelAlign: :right
                                    }
                                  ]
                                },
                                {
                                  header: false,
                                  border: false,
                                  margin: 5,
                                  layout: :hbox,
                                  items: [
                                    {
                                      xtype: 'radiogroup',
                                      labelWidth: 300,
                                      fieldLabel: "Do not auto publish after revision process",
                                      labelAlign: 'top',
                                      margin: '0 10 0 0',
                                      layout: :hbox,
                                      items: [
                                        {
                                          xtype: 'radiofield',
                                          name: 'auto_publish',
                                          width: 100,
                                          boxLabel: 'Yes',
                                          margin: 5,
                                          inputValue: "Y"
                                        },
                                        {
                                          xtype: 'radiofield',
                                          width: 100,
                                          margin: 5,
                                          name: 'auto_publish',
                                          boxLabel: 'No',
                                          inputValue: "N"
                                        }
                                      ]
                                    },{
                                      xtype: 'radiogroup',
                                      labelWidth: 300,
                                      margin: '0 0 0 10',
                                      fieldLabel: "With Mobile version?",
                                      labelAlign: 'top',
                                      layout: :hbox,
                                      items: [
                                        {
                                          xtype: 'radiofield',
                                          name: 'mobile_version_required',
                                          width: 100,
                                          boxLabel: 'Yes',
                                          margin: 5,
                                          inputValue: "Y"
                                        },
                                        {
                                          xtype: 'radiofield',
                                          width: 100,
                                          margin: 5,
                                          name: 'mobile_version_required',
                                          boxLabel: 'No',
                                          inputValue: "N"
                                        }
                                      ]
                                    }
                                  ]
                                }

                              ]
                            }
                        ]
                    },
                    {
                      xtype: :fieldset,
                      title: "emails",
                      margin: 5,
                      layout: :hbox,
                      items:[
                        {
                          name: :email_for_contact_us,
                          field_label: "Email address for the Contact Us form",
                          labelAlign: :top,
                          xtype: :textfield,
                          flex: 1,
                          margin: 5
                        },
                        {
                          name: :additional_email_address,
                          field_label: "Additional Email address to be created",
                          labelAlign: :top,
                          xtype: :textfield,
                          flex: 1,
                          margin: 5
                        }
                      ]
                    }
                ]
            },{
              title: "Other Information",
              width: 500,
              autoScroll: true,
              items: [
                {
                  xtype: :fieldset,
                  title: "Other Info",
                  layout: :hbox,
                  margin: 5,
                  items: [
                      {
                          flex: 1,
                          header: false,
                          border: false,
                          layout: :vbox,
                          items: [
                            {
                                xtype: 'radiogroup',
                                labelWidth: 100,
                                margin: '0 0 0 10',
                                fieldLabel: "Google Map",
                                labelAlign: 'top',
                                layout: :hbox,
                                items: [
                                    {
                                        xtype: 'radiofield',
                                        name: 'google_map_required',
                                        width: 100,
                                        boxLabel: 'Yes',
                                        margin: 5,
                                        inputValue: "Y"
                                    },
                                    {
                                        xtype: 'radiofield',
                                        width: 100,
                                        margin: 5,
                                        name: 'google_map_required',
                                        boxLabel: 'No',
                                        inputValue: "N"
                                    }
                                ]
                            },
                            {
                                name: :social_media_links,
                                field_label: "Social Media Links",
                                labelAlign: :top,
                                margin: 5,
                                width: 400,
                                xtype: :textfield
                            },
                            {
                                name: :no_of_pages,
                                width: 200,
                                field_label: "How many pages is the site",
                                labelAlign: :top,
                                xtype: :textfield
                            },
                            {
                                xtype: :label,
                                text: "What are the Page Titles",
                            },
                            {
                                layout: :hbox,
                                header: false,
                                border: false,
                                items: [
                                    {
                                        header: false,
                                        border: false,
                                        items: get_page_title_items(1)
                                    },
                                    {
                                        header: false,
                                        border: false,
                                        items: get_page_title_items(6)
                                    }
                                ]
                            }
                          ]
                      },
                      {
                         header: false,
                         border: false,
                         flex: 1,
                         items: [
                             {
                                 xtype: :textarea,
                                 field_label: "Please enter any additional comments on design as gathered from the customer",
                                 labelAlign: :top,
                                 name: :additional_comments,
                                 cols: 60,
                                 rows: 5
                             },{
                                 xtype: :textarea,
                                 field_label: "Please enter any additional content or other comments regarding the site",
                                 labelAlign: :top,
                                 name: :additional_contents,
                                 cols: 60,
                                 rows: 5
                             },{
                                 xtype: :textarea,
                                 field_label: "Keywords you wanted in your site (for Basic SEO)",
                                 labelAlign: :top,
                                 name: :keywords_wanted,
                                 cols: 60,
                                 rows: 5
                             }
                         ]
                      }
                  ]
                }
              ]
            }
        ]  + get_page_items
    }
  end

  def get_page_items
    pages = (1..10).collect{|i|
      get_page_item("Page #{i}", "page#{i}_details")
    }
    pages << get_page_item("Additional Info", "additional_details")
    pages
  end

  def get_page_item(title, name)
    {
        title: title,
        items: [
            {name: name, item_id: name, xtype: :textarea, field_label: "Details", labelAlign: :right, rows: 20, cols: 140, margin: 5}
        ]
    }
  end

  def get_page_title_items(num)
    (num..num+4).collect{|i|
      get_page_title_item("#{i}", "page#{i}_title")
    }
  end

  def get_page_title_item(label, name)
    {name: name, field_label: label, labelAlign: :right, xtype: :textfield, labelWidth: 20}
  end
end
