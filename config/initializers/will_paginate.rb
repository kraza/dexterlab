# based on henrik nyh's public extension to will_paginate:
# https://gist.github.com/1214011/7ffaa86636e5b5b1fe872f9273834373c58f7ab6

require 'will_paginate/view_helpers/action_view'

module WillPaginate

  WillPaginate.per_page = 6

  module ActionView
    def will_paginate(collection = nil, options = {})
      options[:renderer] ||= BootstrapLinkRenderer
      super.try :html_safe
    end

    class BootstrapLinkRenderer < LinkRenderer
      protected

      def html_container(html)
        tag :div, tag(:ul, html), container_attributes
      end

      def page_number(page)
        tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
      end
    end
  end
end
