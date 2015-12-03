module ApplicationHelper
  def options
    return [['Radio', 1],
            ['Checkbox', 2],
            ['Text', 3],
            ['Slider', 4]]
  end

  def tag_for_options(i)
    mas= %w(li input text_area_tag Slider)
    return mas[i]
  end
end
