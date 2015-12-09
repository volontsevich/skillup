class SurveyMailsController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_survey_mail, only: :destroy
  before_filter :find_survey_mails, only: :send_mail

  def destroy
    @survey_mail.destroy
  end

  def send_mail
    UserMailer.send_survey(@survey, @emails).deliver_now
    redirect_to survey_path(@survey)
  end

  private
  def find_survey_mail
    @survey_mail=SurveyMail.find(params[:format])
  end

  def find_survey_mails
    @survey = Survey.find(params[:id])
    @emails=SurveyMail.where('survey_id=?', @survey.id).select(:address)
  end

  def survey_mail_params
    params.require(:survey_mail).permit(:id, :address)
  end
end
