class PagesController < ApplicationController
    def show
       file = File.new("/home/giridhar/Desktop/sample.html","w")
       File.open(file,"w+") {|file| file.puts "hello world!"}
    end
end