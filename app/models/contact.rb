class Contact < ActiveRecord::Base
	validates_presence_of :conferences, :names, :company, :estimated_date, :type_meeting, :theme, :start_time, :end_time, :city, :assistants, :phone, :email, :message
	validates_numericality_of :assistants
end
