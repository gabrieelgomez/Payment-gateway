class UserMailer < ApplicationMailer
  default from: 'no-reply@gustavohenao.com'

	def contact_email(contact)
		@contact = contact
		mail(to: 'gustavohenao@gustavohenao.com', subject: 'Solicitud de nueva conferencia')
	end
end
