class UserMailer < ApplicationMailer
	default from: 'giridar@example.com'
	def contact_email(name,email,book_name,book_price)
		@email = email
		@name = name
		@book_name = book_name
		@book_price = book_price

		mail(to: @email, subject: "New book details")
	end
end
	