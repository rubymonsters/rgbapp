module Admin::TemplatesHelper

ExampleData = {
  application_mail: {
    applicant_name: "Ruby",
    event_date: "01.01.3000",
    confirmation_deadline: "31.12.2999"
  },
  selection_mail: {
    applicant_name: "Ruby",
    event_date: "01.01.3000",
    confirmation_deadline: "31.12.2999",
    confirmation_link: "http://www.exampleconfirmationlink.com"
  },
  rejection_mail: {
    applicant_name: "Ruby"
  },
  reminder_mail: {
    applicant_name: "Ruby",
    event_date: "01.01.3000",
    event_place: "Wakanda"
  }
}

  def preview_template(template_name)
    begin
      Mustache.render(@event[template_name], ExampleData[template_name.to_sym]
      )
    rescue => e
      "Error: #{e.message}"
    end
  end
end
