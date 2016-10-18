class BookDetailsWorker
  include Sidekiq::Worker
  sidekiq_options queue: "default", retry: true
  def perform(book_id)
    #render html: "<script>balert('book saved!')</script>".html_safe

    book = Book.find(book_id)
    book_name = book.title
    book_price = book.price
    book_author_id = book.user_id
    @users = User.all 
    @users.each do | user|
      puts user.name
      puts user.email 
      puts "#{book_name}"
      puts "#{book_price}"
       UserMailer.contact_email(user.name,user.email,book_name,book_price).deliver
    end  
  end
end