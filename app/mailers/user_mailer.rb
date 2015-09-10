class UserMailer < ApplicationMailer
  default from: 'no-reply@gustavohenao.com'

	def contact_email(contact)
		@contact = contact
		mail(to: 'hugo200440@gmail.com', subject: 'Solicitud de nueva conferencia')
	end
end
