module CoachApplicationsHelper
    def coach_application_states_for_select
        CoachApplication.states.map do |key, _|
          [CoachApplication.human_attribute_name("state.#{key}"), key]
        end
      end
end
