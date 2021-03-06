module RenderSortableTreeHelper
  # DOC:
  # We use Helper Methods for tree building,
  # because it's faster than View Templates and Partials

  # USE h (helper), for View Helpers call
  # Example: h.url_for(args) | h.link_to(args)

  # SECURITY note
  # Prepare your data on server side for rendering
  # or use h.html_escape(node.content)
  # for escape potentially dangerous content

  # USE **option** method
  # to get all args form TheSortableTreeHelper renderer

  # BANCHMARK
  class Render < TreeRender::Base
    def render_node
      node = options[:node]
      opts = options[:opts]

      "
        <li id='#{ node.id }_#{ opts[:klass] }'>
          <div class='item'>
            <i class='handle'></i>
            #{ show_link }
            <p>#{ h.html_escape node.content }</p>
            #{ controls }
          </div>
          #{ children }
        </li>
      "
    end

    def show_link
      node = options[:node]
      link = h.link_to(node.title, node)
      "<h4>#{ link }</h4>"
    end

    def controls
      node      = options[:node]
      opts      = options[:opts]

      link_path = h.link_to(node.title, node)

      edit_path = h.url_for(:controller => opts[:klass].pluralize, :action => :edit, :id => node)
      edit_path = h.url_for(:controller => opts[:klass].pluralize, :action => :edit, :id => node)
      
      delete_confirm = 'delete'
      edit_title     = 'edit title'
      delete_title   = 'delete title'

      "
        <div class='controls'>
          <a class='edit'   href='#{edit_path}' title='#{edit_title}'></a>
          <a class='delete' href='#{link_path}' data-confirm='#{delete_confirm}' data-method='delete' title='#{delete_title}'></a>
        </div>
      "
    end

    def children
      "<ol class='nested_set'>#{ options[:children] }</ol>" unless options[:children].blank?
    end
  end
end