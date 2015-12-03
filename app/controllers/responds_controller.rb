class RespondsController < ApplicationController
  before_action :authenticate_user!

  def new
    @survey_id=params[:survey]
    @survey=Survey.find(@survey_id)
    @respond = Respond.new
  end

  def create
    if params[:respond].present?
      params[:respond][:questions].each do |k, v|

        v[:content]=v[:reply].to_json
        v[:content]="" if v[:content]=="null"
        Respond.create(survey_id: v[:survey], question_id: v[:id], content: v[:content], user_id: current_user.id)
      end
    end
      redirect_to root_path

  end

  private
  def respond_params
    params.require(:respond)
  end


end
