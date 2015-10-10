module ApplicationHelper
  def progressbar(valuemax, valuenow, value)
    frac = valuemax == 0 ? 0 : valuenow.to_f * 100 / valuemax
    content_tag(:div, class: 'progress') do
      content_tag(:div, class: 'progress-bar', role: 'progressbar',
        style: "width: #{frac}%",
        aria: { valuenow: frac.to_i, valuemin: 0, valuemax: 100}) do
        value
      end
    end
  end
end
