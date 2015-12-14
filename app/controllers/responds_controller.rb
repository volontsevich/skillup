class RespondsController < ApplicationController
  include My
  before_action :authenticate_user!, except: [:new, :create]
  before_action :get_user_email, only: [:new, :create]

  def new
    prepare_unique_respond
  end

  def create
    create_responds if params[:respond].present? && !@user_mail.nil?
    redirect_to root_path
  end

  private
  def respond_params
    params.require(:respond)
  end

  def prepare_unique_respond

    if @user_mail!="nul"
      already_had_respond = Respond.where('survey_id=? and user_mail=?', @survey_id, @user_mail).size > 0
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
    else
      @err = "Wrong user!"
      render 'responds/error_message'
    end
  end

  def get_user_email
    if !params[:survey].nil?
      @survey_id = params[:survey]
    else
      @survey_id = params[:respond][:survey]
    end
    if current_user.nil?
      if !params[:user].nil?
        @respond_user = params[:user]
      else
        @respond_user = params[:respond][:user]
      end
      if SurveyMail.for_survey(@survey_id).where(address: @respond_user).size > 0
        @user_mail=@respond_user
      else
        @user_mail = "nul"
      end
    else
      @user_mail=current_user.email
    end

  end

  def exp_date_came
    Date.current>@survey.exp_date
  end

  def create_responds

    params[:respond][:questions].each do |k, v|
      v[:content]=v[:reply].to_json
      v[:content]="" if v[:content]=="null"
      Respond.create(survey_id: v[:survey], question_id: v[:id], content: v[:content], user_mail: @user_mail)
    end

  end

end
