class Order < ActiveRecord::Base

  SITE_TYPE_MAP = {"C" => "Custom", "S" => "Standard"}

  belongs_to :company, :class_name => "WebsiteCompany"
  belongs_to :sales_person
  has_many :time_lines

  after_create :init_time_lines

  default_scope lambda{ order("id DESC") }

  def site_url
    purchased_url || transferred_url
  end

  private

  def init_time_lines
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    TimeLine::TIME_LINE_JOBS.each do |k, v|
      time_lines.create!(:job => k.to_s)
    end
  end
end
