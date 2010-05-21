module TabFu
  module ListHelper
    class List
      def initialize(context, list_id = '__default', options = {})
        
        @always_link = options.delete(:always_link) || false
        @context = context
        @list_id = list_id.to_s
      end

      def method_missing(tab, name, link = '#', tab_class = '', a_class = '', *options)
        opts = options.extract_options!
        prepend = opts.delete(:prepend)
        append = opts.delete(:append)
        li_class = tab_class.blank? ? '' : " class=\"#{tab_class}\""
        link_classes = []
        link_classes << a_class unless a_class.blank?
        link_classes << 'current' if tab.to_s == current_tab.to_s
        options.push(:class => link_classes.join(' ')) unless link_classes.empty?
        text = @always_link || active_class.blank? ? @context.link_to(name, link, *options) : name
        "<li#{li_class}>#{prepend}#{text}#{append}</li>"
      end

      private
      def current_tab
        @context.controller.instance_variable_get('@__current_tab')[@list_id]
      rescue
        nil
      end
    end
  end
end