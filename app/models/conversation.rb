class Conversation < ActiveRecord::Base

  belongs_to :order
  belongs_to :sender, :class_name => "User"

  before_validation :set_defaults

  default_scope lambda{ order("id DESC") }

  private

  def set_defaults
    self.conversation_date = Time.current
    self.sender = User.current
  end

end