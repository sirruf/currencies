# frozen_string_literal: true

#
# Main Helper
#
module ApplicationHelper
  def rank(report_item)
    if report_item.max_value
      '<span class="badge badge-success">Maximum</span>'.html_safe
    elsif report_item.min_value
      '<span class="badge badge-danger">Minimum</span>'.html_safe
    else
      ''
    end
  end

  def row_color(report_item)
    if report_item.max_value
      'table-success'
    elsif report_item.min_value
      'table-danger'
    else
      ''
    end
  end

  def bootstrap_class_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info' }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div,
                         message,
                         class: get_class_by_type(msg_type)) do
               get_concat(message)
             end)
    end
    nil
  end

  private

  def get_concat(message)
    concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
    concat message
  end

  def get_class_by_type(msg_type)
    "alert #{bootstrap_class_for(msg_type)}"
  end
end
