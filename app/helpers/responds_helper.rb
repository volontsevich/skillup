module RespondsHelper
  def find_responds_by_survey_and_question(a, b)
    Respond.where('survey_id=? and question_id=?', a, b)
  end
end
