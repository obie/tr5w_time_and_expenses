class User < ApplicationRecord
  include Authem::User

  has_secure_token

  store :properties, coder: JSON

  belongs_to :client, -> { includes(:billable_weeks) }, optional: true

  has_many :timesheets,
           :before_remove => :check_timesheet_destruction,
           :dependent => :destroy,
           :inverse_of => :user

  has_many :billable_weeks, :through => :timesheets

  has_many :expense_reports

  has_one :avatar, :dependent => :destroy

  validates :name, presence: true
  validates :email, presence: true

  def draft_timesheets
    timesheets.draft
  end

  private

  def check_timesheet_destruction(timesheet)
    if timesheet.submitted?
      raise "Cannot destroy a submitted timesheet."
    end
  end
end
