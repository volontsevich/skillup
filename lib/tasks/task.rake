namespace :skillup do
  desc "Send email to users of first survey"
  task :viktor => :environment do
    Survey.all.each do |survey|
      if Date.current >= survey.send_date
        emails = SurveyMail.for_survey_not_sent(survey.id)
        emails.each do |email|
          UserMailer.send_survey(survey, email).deliver_now
          SurveyMail.find(email[:id]).update(sent: true)
        end
      end
    end
  end
end