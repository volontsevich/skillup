class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_question, only: :destroy

  def destroy
    @question.destroy
  end

  private
  def find_question
    @question=Question.find(params[:format])
  end
end
