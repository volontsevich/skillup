class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'
  default to: 'v.volontsevich@mobidev.biz'

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  end

  def new_user(user)
    @user=user
    mail(subject: "New User: #{user.email}")
  end

  def send_survey(survey, mail)
    link_for_user=new_respond_url(survey: survey.id, user: mail[:address].to_s).to_s
    template_name = 'new-survey'
    template_content = []
    message = {
        to: [{email: mail[:address]}],
        subject: "New Survey: #{survey.name}",
        merge_vars: [
            {rcpt: mail[:address],
             vars: [
                 {name: "SURVEY_NAME", content: "You should go to <a href='#{link_for_user}'>this link</a> and pass new survey!</h4>"}
             ]
            }
        ]
    }
    mandrill_client.messages.send_template template_name, template_content, message
  end
end

