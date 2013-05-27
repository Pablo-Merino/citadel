module Citadel
  require 'sinatra/base'
  require 'haml'

  class Server < Sinatra::Base

    use Rack::Auth::Basic, "Citadel Protected Area" do |username, password|
      username == Settings[:username] && password == Settings[:password]
    end

    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public_dir, "#{dir}/server/public"

    set :static, true
    set :lock, true

    get '/favicon.ico' do
    end

    get '/' do
      @inspections = settings.citadel.database.inspections.all.take(5).reverse
      haml :index
    end

    get '/all' do
      @inspections = settings.citadel.database.inspections.all.reverse
      haml :index
    end

    get '/pull' do
      @code_response = settings.citadel.pull_git_repo!
      if @code_response[:success]
        redirect '/'
      else
        haml :error
      end
    end

    post '/pull' do
      settings.citadel.pull_git_repo!
      "OK"
    end 


    get '/:id' do |id|
      @inspection = settings.citadel.database.inspections.where(:sha => id).first
      haml :show
    end

    def self.start(host='0.0.0.0', port=8080, citadel_core)
      set :bind, host
      set :port, port
      set :citadel, citadel_core
      Server.run!
    end
  end

end