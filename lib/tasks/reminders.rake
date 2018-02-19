task :send_reminders => :environment do
  Event.where(scheduled_at: 2.days.from_now.to_date.all_day).each do |event|
    event.applications.where(selected: true, attendance_confirmed: true). each do |application|
      UserMailer.reminder_mail(application).deliver_later
    end
  end
end
