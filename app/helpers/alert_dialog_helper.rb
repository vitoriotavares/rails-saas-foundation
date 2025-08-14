module AlertDialogHelper
  def alert_dialog(id: nil, &block)
    dialog_id = id || "alert-dialog-#{SecureRandom.hex(4)}"
    content_for(:alert_dialogs) do
      content_tag :div, 
                  class: "alert-dialog alert-dialog-overlay hidden", 
                  id: dialog_id,
                  data: { 
                    controller: "alert-dialog",
                    alert_dialog_target: "overlay",
                    action: "click->alert-dialog#closeOnOverlay keydown@window->alert-dialog#closeOnEscape"
                  } do
        capture(&block) if block_given?
      end
    end
    dialog_id
  end

  def alert_dialog_content(title: nil, description: nil, icon: nil, &block)
    content_tag :div, class: "alert-dialog-content", data: { alert_dialog_target: "content" } do
      content = ""
      
      if title || description || icon
        content += content_tag :div, class: "alert-dialog-header" do
          header_content = ""
          
          if icon
            header_content += content_tag :div, class: "alert-dialog-icon #{icon[:type] || 'destructive'}" do
              icon[:svg] || default_warning_icon
            end
          end
          
          header_content += content_tag :div do
            title_content = ""
            title_content += content_tag(:h2, title, class: "alert-dialog-title") if title
            title_content += content_tag(:p, description, class: "alert-dialog-description") if description
            title_content.html_safe
          end
          
          header_content.html_safe
        end
      end
      
      content += capture(&block) if block_given?
      content.html_safe
    end
  end

  def alert_dialog_footer(&block)
    content_tag :div, class: "alert-dialog-footer" do
      capture(&block) if block_given?
    end
  end

  def alert_dialog_button(text, type: :cancel, **options, &block)
    css_classes = "alert-dialog-button #{type}"
    css_classes += " #{options[:class]}" if options[:class]
    
    action = case type
             when :cancel, :close
               "click->alert-dialog#close"
             when :confirm, :destructive
               options[:action] || "click->alert-dialog#close"
             else
               options[:action]
             end

    button_options = {
      class: css_classes,
      data: { action: action }
    }.merge(options.except(:class, :action))

    if block_given?
      content_tag :button, button_options do
        capture(&block)
      end
    else
      content_tag :button, text, button_options
    end
  end

  def render_alert_dialogs
    content_for(:alert_dialogs)
  end

  def show_alert_dialog(dialog_id)
    content_tag :script do
      "document.getElementById('#{dialog_id}').dispatchEvent(new CustomEvent('alert-dialog:show'));".html_safe
    end
  end

  private

  def default_warning_icon
    content_tag :svg, class: "w-4 h-4", fill: "currentColor", viewBox: "0 0 20 20" do
      content_tag :path, "",
                  "fill-rule": "evenodd",
                  d: "M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z",
                  "clip-rule": "evenodd"
    end
  end
end