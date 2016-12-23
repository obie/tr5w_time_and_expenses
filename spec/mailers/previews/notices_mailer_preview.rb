# Preview all emails at http://localhost:3000/rails/mailers/notices_mailer
class NoticesMailerPreview < ActionMailer::Preview
  def late_timesheet
    user = User.find_by!(email: "obie@trxw.com")
    NoticesMailer.late_timesheet(recipient: user, week_of: 1.week.ago)
  end
end
