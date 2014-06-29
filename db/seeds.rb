# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env == "development"
  FacilityOwner.destroy_all

  facility_owner = FacilityOwner.create!(:company_name => 'ASEC', :company_code => 'ASEC')

  Company.current = facility_owner

  SuperAdmin.destroy_all
  users = ['admin1', 'admin2']
  first_names = ["Emma", "Tina",]
  last_names = ["Will", "Miller"]
  users.each_with_index do |role, i|
    user = SuperAdmin.create(first_name: first_names[i], last_name: last_names[i], email: "#{role}@workflowtool.com", password: "test1234", password_confirmation: "test1234")
  end

  SalesPerson.destroy_all
  users = ['sp1', 'sp2']
  first_names = ["David", "James",]
  last_names = ["Smith", "Smith"]
  users.each_with_index do |role, i|
    user = SalesPerson.create(first_name: first_names[i], last_name: last_names[i], email: "#{role}@workflowtool.com", password: "test1234", password_confirmation: "test1234")
  end
end
