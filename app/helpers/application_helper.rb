# frozen_string_literal: true

#
# Main Helper
#
module ApplicationHelper
  def rank(report_item)
    if report_item.max_value then
      '<span class="badge badge-success">Maximum</span>'.html_safe
    else
      if report_item.min_value
        '<span class="badge badge-danger">Minimum</span>'.html_safe
      else
        ''
      end
    end
  end
  def row_color(report_item)
    if report_item.max_value then
      'table-success'
    else
      if report_item.min_value
        'table-danger'
      else
        ''
      end
    end
  end
end
