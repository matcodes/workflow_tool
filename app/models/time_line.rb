class TimeLine < ActiveRecord::Base

  TIME_LINE_JOBS = {"start_date" => "Start Date", "mock_up_approved" => "Mock Up Approved", "site_preview" => "Site Preview (Home Page / Sub Page)",
                    "account_mgr_content" => "Account Manager To Provide The Content", "init_feedback" => "Initial Feedback",
                    "first_approval" => "Site Send For First Approval", "feedback_review" => "Feedback On Review",
                    "edit_site_based_review" => "Edits To Site Based On Review", "register_info" => "Hosting And Registrar Information",
                    "review" => "Review", "feedback_based_on_review" => "Feedback  Based On Review", "edit_based_on_feedback" => "Edits Based On Feedback",
                    "final_review" => "Final Review and approval to go Live", "go_live" => "Go Live"}

  belongs_to :order

end