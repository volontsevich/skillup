class SurveysController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :change_params_to_json, only: [:update, :create]
  before_filter :find_survey, only: [:show, :edit, :update, :destroy]
  before_filter :find_survey_emails, only: [:show]
  before_filter :find_surveys, only: :index
  include SurveysHelper
  include My

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
    answers_without_json
    responds_without_json
  end


  def edit
    get_obj_array
  end

  def update
    @survey.update(survey_params)
    redirect_to @survey
  end

  def destroy
    @survey.destroy
    redirect_to surveys_index_path
  end

  private

  def answers_without_json
    @answers = []
    @survey.questions.each do |question|
      answers = ''
      if question.meta.length != 0
        answers_array = ActiveSupport::JSON.decode(question.meta)
        i = 0
        answers_array.each do |k, v|
          if question.option == question_types[:'Slider']
            answers += '<li class="li_without_marker">'
            answers += 'Min value ' if i == 0
            answers += 'Max value ' if i == 1
            answers += 'By default ' if i == 2
          else
            answers += '<li>'
          end
          answers +=v['content']+'</li>'
          i +=1
        end
      end
      @answers.push(answers.to_s)
    end

  end

  def responds_without_json
    @responds_without_json=[]
    @survey.questions.each do |question|
      responds_with_json=Respond.for_question(question.id).group(:content).count
      responds_normalized=[]
      responds_with_json.each do |k1, v1|
        buf=''
        respond= ActiveSupport::JSON.decode(k1)
        respond.each do |k2, v2|
          buf+= v2['content']+', '
        end
        buf=buf[0, buf.size-2]
        responds_normalized.push(buf, v1.to_s)
      end
      @responds_without_json.push(Hash[*responds_normalized.flatten])
    end
  end

  def find_survey_emails
    @emails=SurveyMail.for_survey(@survey.id)
  end

  def create_survey
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
    params.require(:survey).permit(:id, :name, :user_id, :send_date, :start_date, :exp_date,
                                   questions_attributes: [:id, :content, :option, :meta], survey_mails_attributes: [:id, :address, :sent])
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
          @surveys=Survey.for_user(params[:user_id])
        end
      else
        @surveys=Survey.for_user(current_user.id)
      end
      @surveys=@surveys.page(params[:page]).per(5)
    end
  end

end
