module My

  def get_obj_array
    @obj_array=[]
    @survey.questions.each_with_index do |q, i|
      if q.meta.length != 0
        @obj_array.push(ActiveSupport::JSON.decode(q.meta))
      else
        @obj_array.push(0)
      end
    end
  end

end