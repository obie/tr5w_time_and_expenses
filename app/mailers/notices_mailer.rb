class NoticesMailer < ActionMailer::Base
  def late_timesheet(recipient:, week_of:)
    @recipient = recipient
    @week_of = week_of
    attachments["shame.jpg"] = File.read("app/assets/images/shame.jpg")
    mail to: recipient.email,
         subject: "[T&E] Your timesheet is late!!!"
  end

  def missing_timesheets_for_last_week
    mail to: User.missing_timesheets_for_last_week.pluck(:email),
         subject: "[T&E] Your timesheet is late!!!"
  end
end
