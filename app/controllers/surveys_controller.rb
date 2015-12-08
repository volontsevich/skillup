class SurveysController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_filter :find_survey,
                only: [:show, :edit, :update, :destroy]
  before_filter :find_survey_emails, only: [:show]
  before_filter :find_surveys, only: :index

  def new
    @survey = Survey.new
    @survey.questions.build
  end

  def create
    create_survey
  end

  def index

  end

  def show

  end

  def edit

  end

  def update
    change_params_to_json
    @survey.update(survey_params)
    redirect_to @survey
  end

  def destroy
    @survey.destroy
    redirect_to surveys_index_path
  end





  private
  def find_survey_emails
    @emails=SurveyMail.where('survey_id=?', @survey.id).select(:address)
  end

  def create_survey
    change_params_to_json
    @survey = current_user.surveys.new(survey_params)
    if @survey.save
      redirect_to @survey
    else
      render 'new'
    end
  end

  def change_params_to_json
    if params[:survey][:questions_attributes].present?
      params[:survey][:questions_attributes].each do |k, v|
        v[:meta]=v[:answers_attributes].to_json
        v[:meta]="" if v[:meta]=="null"
      end
    end
  end

  def survey_params
    params.require(:survey).permit(:id, :name, :user_id, :send_date, :start_date, :exp_date, questions_attributes: [:id, :content, :option, :meta],
                                   survey_mails_attributes: [:id, :address])
  end

  def find_survey
    @survey = Survey.find(params[:id])
  end

  def find_surveys
    if user_signed_in?
      if current_user.admin?
        if params[:user_id].nil?
          @surveys=Survey.all
        else
          @surveys=Survey.where(user_id: params[:user_id])
        end
      else
        @surveys=Survey.where(user_id: current_user.id)
      end
    end
  end

end
