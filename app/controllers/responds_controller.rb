class RespondsController < ApplicationController
  include My
  before_action :authenticate_user!, except: :new

  def new
    prepare_unique_respond
  end

  def create
    if params[:respond].present?
      create_responds
    end
    redirect_to root_path
  end

  private
  def respond_params
    params.require(:respond)
  end

  def prepare_unique_respond
    @survey_id = params[:survey]
    user_id=current_user.id
    if current_user.nil?
      @respond_user = params[:user]
      if SurveyMail.for_survey(@survey_id).find(address: @respond_user).size > 0
        user_id=''
      end
    end
    already_had_respond = Respond.where('survey_id=? and user_id=?', @survey_id, user_id).size > 0
    if !already_had_respond
      @survey=Survey.find(@survey_id)
      if !exp_date_came
        @respond = Respond.new
        get_obj_array
      else
        @err = "Survey is expired"
        render 'responds/error_message'
      end
    else
      @err = "You've already answered this survey!"
      render 'responds/error_message'
    end
  end

  def exp_date_came
    return Date.current>@survey.exp_date
  end

  def create_responds
    params[:respond][:questions].each do |k, v|
      v[:content]=v[:reply].to_json
      v[:content]="" if v[:content]=="null"
      Respond.create(survey_id: v[:survey], question_id: v[:id], content: v[:content], user_id: current_user.id)
    end
  end

end
