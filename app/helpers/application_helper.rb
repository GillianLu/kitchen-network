module ApplicationHelper
    def active_class(path)
      current_page?(path) ? 'tab-link-active' : 'tab-link-inactive'
    end
  
    def aria_current(path)
      current_page?(path) ? 'page' : nil
    end
end
  