class SurveyMailsController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_survey_mail, only: :destroy
  before_filter :find_survey_mails, only: [:send_mail, :index]

  def new

  end

  def index

  end

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
    if params[:id].nil?
      if current_user.admin?
        @surveys=Survey.all
        @emails=SurveyMail.all
      else
        @surveys=Survey.for_user(current_user.id)
        @ids=Survey.pluck(:id)
        @emails=SurveyMail.for_surveys(@ids)
      end
    else
      @survey = Survey.find(params[:id])
      @emails=SurveyMail.for_survey(@survey.id)
    end
  end

  def survey_mail_params
    params.require(:survey_mail).permit(:id, :address, :sent)
  end
end
