module ApplicationHelper

	include SessionsHelper

	# generates the appropriate class name for flash messages when generating
	# their HTML for the main application layout
	def flash_class(level)
		case level
			when :notice then 'alert-info'
			when :error then 'alert-error'
			when :alert then '' # just use the default alert styling
		end
	end
end

