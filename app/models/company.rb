# == Schema Information
#
# Table name: companies
#
#  id           :integer          not null, primary key
#  company_name :string(255)      not null
#  company_type :string(255)      not null
#  lock_version :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Company < ActiveRecord::Base

  self.inheritance_column = :company_type
  
  has_many :company_users, :dependent =>  :destroy
  has_many :users, :through => :company_users	
  
  def self.current=(comp_obj)
    Thread.current[:company] = comp_obj
  end

  def self.current
    Thread.current[:company]
  end

  def facility_owner?
    self.is_a? FacilityOwner
  end
end
