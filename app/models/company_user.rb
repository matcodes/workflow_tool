# == Schema Information
#
# Table name: company_users
#
#  id           :integer          not null, primary key
#  company_id   :integer          not null
#  user_id      :integer          not null
#  lock_version :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CompanyUser < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  
  scope :org_scope, lambda {where(:company_id => Company.current.id)}
end
