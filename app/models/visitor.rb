class Visitor < ActiveRecord::Base
  validates :ip_address, presence: true
  
  scope :recent, -> { where('visited_at > ?', 1.hour.ago) }
  scope :today, -> { where('visited_at > ?', 1.day.ago) }
  
  def self.record_visit(ip, user_agent)
    create!(
      ip_address: ip,
      user_agent: user_agent,
      visited_at: Time.now
    )
  end
end
