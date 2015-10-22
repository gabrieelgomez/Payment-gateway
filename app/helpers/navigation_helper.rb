module NavigationHelper

	def current_navigation?(*args)
		args.include? current_path.camelize	
	end

	def tab(name, icon, link, current)	
		link_to link, class: "collapsible-header #{'current' if current }" do
    	content_tag(:i, icon, class: "mi md-18")+name
    end
	end

	def header_tab(name, icon, current) 
		content_tag :div, class: "collapsable collapsible-header #{'active current' if current }" do
			content_tag(:i, icon, class: "mi md-18")+name
		end
	end

	def body_tab(&block)
		content_tag :div, class: "collapsible-body" do
			content_tag(:ul, capture(&block), class: "pageslide-sub-menu")
		end
	end

	def link_tab(name, link, current)
		content_tag :li do
			link_to name, link, class: "#{'current' if current }"
		end
	end

	private

	def current_path
		path = controller_path.split("/")
		case path.size
			when 1
				path.first
			when 2
				path.first.camelize
		end
	end
end