class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = current_user.books
    current_user.books.each do |book|
      puts "=========================="
      puts book.title
      puts current_user.name
      @file_path =File.new("./public/#{book.title}_book.html","w+")
      user_book_page_html = ActionController::Base.new.send(:render_to_string,:template => 'books/book_details',
        :locals => {:user_name => current_user.name,:book  => book.title,:created_at => book.created_at, :books_path=> books_path})
      file_opened = File.open(@file_path,"wb") {|file| file.write(user_book_page_html)}
    end
    
  # @files.each do |file| 
  #  file = ActionController::Base.new.send(:render_to_string,template: "books/show", 
  #    locals: {
  #    user_name: current_user.name,
  #    books: current_user.books
  #    })a


  #render "public/#{@user_name}_books.html"
end 

def book_details
  
end

def show
  @book = Book.find(params[:id])
end

  # GET /books/new  
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = current_user.books.build(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
  #render html: "<script>alert('book saved!')</script>".html_safe
        format.json { render :show, status: :created, location: @book }
        puts "=========="
        puts "#{@book.id}"
        BookDetailsWorker.new.perform(@book.id)
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:title, :price,:user_id)
  end
end
