class BillableWeek < ApplicationRecord
  attribute :start_date, :datetime, default: -> { Time.now }

  belongs_to :client
  belongs_to :billing_code, optional: true
  belongs_to :timesheet

  validates_presence_of :start_date
  validates_uniqueness_of :client_id, scope: :timesheet_id

  def total_hours
    %w{ mon tues wednes thurs fri satur sun }.inject(0) do |acc,day|
      acc + send("#{day}day_hours").to_i
    end
  end
end
