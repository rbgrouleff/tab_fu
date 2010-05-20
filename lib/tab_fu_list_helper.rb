module TabFu
  module ListHelper
    class List
      def initialize(context, list_id = '__default', options = {})
        
        @always_link = options.delete(:always_link) || false
        @context = context
        @list_id = list_id.to_s
      end

      def method_missing(tab, name, link = '#', *options)
        prepend = options.delete(:prepend)
        append = options.delete(:append)
        options.push(:class => 'current') if tab.to_s == current_tab.to_s
        text = @always_link || active_class.blank? ? @context.link_to(name, link, *options) : name
        "<li>#{prepend}#{text}#{append}</li>"
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