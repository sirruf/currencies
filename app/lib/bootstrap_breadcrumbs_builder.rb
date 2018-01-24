# frozen_string_literal: true

#
# Custom Breadcrumbs Builder
#
class BootstrapBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.content_tag(:ol, class: 'breadcrumb') do
      @elements.collect do |element|
        render_element(element)
      end.join.html_safe
    end
  end

  def render_element(element)
    divider = ''
    current = @context.current_page?(compute_path(element))
    @context.content_tag(:li, class: element_class(current)) do
      link_or_text = element_context(element)
      divider = divider_context unless current
      link_or_text + divider
    end
  end

  private

  def divider_context
    @context.content_tag(:span,
                         (@options[:separator] || '/').html_safe,
                         class: 'breadcrumb-item')
  end

  def element_class(current)
    "breadcrumb-item #{('active' if current)}"
  end

  def element_context(element)
    @context.link_to_unless_current(compute_name(element),
                                    compute_path(element),
                                    element.options)
  end
end
