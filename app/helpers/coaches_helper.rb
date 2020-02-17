module CoachesHelper
  def genders_for_form
    Coach::GENDERS.map do |gender|
      [gender.to_s.humanize, gender]
    end
  end
end
