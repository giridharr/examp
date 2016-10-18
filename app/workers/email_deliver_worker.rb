class EmailDeliverWorker
  include sidekiq::worker 
  sidekiq_options retry: false
  def perform(users)
    @users = User.all
    @users.each do |u|
      puts "================"
      puts u.email
    end
  end
end