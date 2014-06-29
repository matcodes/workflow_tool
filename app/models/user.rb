# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  last_name              :string(255)      not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  lock_version           :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_type              :string(255)      not null
#

class User < ActiveRecord::Base

  self.inheritance_column = :user_type
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  USER_TYPES_STORE = [["SuperAdmin", "Super Admin"], ["SalesPerson", "Sales Person"], ["Advertiser", "Advertiser"], ["Designer", "Designer"],
                      ["DomainPurchaser", "DomainPurchaser"], ["ItPerson", "IT Person"]]
         
	has_many :company_users, :dependent =>  :destroy
  has_many :companies, :through => :company_users
  
  after_create :associate_to_company
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :encrypted_password, :sign_in_count  

	def full_name
	  "#{first_name} #{last_name}"
  end

  def user_role
    self.class.name
  end
	
  def self.current=(user_obj)
    Thread.current[:user] = user_obj
    Company.current = user_obj.default_company if user_obj
  end

  def self.current
    Thread.current[:user]
  end
  
  def default_company
    self.companies.first
  end
  
  private
  
  def associate_to_company
		self.companies << Company.current
  end
  
end
