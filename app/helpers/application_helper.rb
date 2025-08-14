module ApplicationHelper
  include SeoHelper
  include AlertDialogHelper

  def flash_class(level)
    case level.to_s
    when 'notice'
      'bg-green-100 border-green-400 text-green-700'
    when 'alert', 'error'
      'bg-red-100 border-red-400 text-red-700'
    when 'warning'
      'bg-yellow-100 border-yellow-400 text-yellow-700'
    else
      'bg-blue-100 border-blue-400 text-blue-700'
    end
  end

  def current_year
    Date.current.year
  end

  def page_heading(title = nil, subtitle = nil)
    content_for :page_heading do
      content_tag :div, class: 'mb-8' do
        heading = content_tag :h1, title, class: 'text-3xl font-bold text-gray-900'
        if subtitle.present?
          heading + content_tag(:p, subtitle, class: 'text-gray-600 mt-2')
        else
          heading
        end
      end
    end
  end
end
