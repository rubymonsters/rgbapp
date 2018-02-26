task :send_reminders => :environment do
  Event.send_reminders
end
