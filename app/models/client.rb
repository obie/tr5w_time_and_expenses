class Client < ApplicationRecord
  has_many :billing_codes
  has_many :billable_weeks
  has_many :timesheets, -> { distinct }, :through => :billable_weeks
  has_many :contact_cards
  has_many :people_contacts, :through => :contact_cards, 
           :source => :contact
  has_many :business_contacts, :through => :contact_cards, 
           :source => :contact
  has_many :users, :dependent => :destroy

  scope :recent, -> { where("created_at > ?", 1.year.ago).order("created_at desc") }
  scope :by_spend, -> { order("total_spend desc") }
  scope :by_hottest_spend_day, -> { group("hottest_spend_day, total_spend, code") }

  validates_presence_of :name

  def self.all_with_counts
    all.map do |client| 
      { :id => client.id, :draft_timesheets_count => client.timesheets.draft.count }
    end
  end

end
