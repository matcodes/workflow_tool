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

class FacilityOwner < Company

end

