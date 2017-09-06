class Newsletter < ActiveRecord::Base
	validates_uniqueness_of :email
	validates_presence_of :email
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, message: "No es un email valido" }
end
