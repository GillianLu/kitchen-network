module ApplicationHelper
    def active_class(path, active_class: 'tab-link-active')
      current_page?(path) ? active_class : 'tab-link-inactive'
    end
  
    def aria_current(path)
      current_page?(path) ? 'page' : nil
    end
end