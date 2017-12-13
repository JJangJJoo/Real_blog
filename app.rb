require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper' # metagem, requires common plugins too.
require './model.rb' #Database 관련 파일(model.rb)

set :bind, '0.0.0.0'

enable :sessions

get '/' do
  @posts = Post.all.reverse #[1번포스트 객체, 2번포스트객체, 3번객체...]
  erb :index
end

get '/create' do
  Post.create(
    :title => params["title"],
    :body => params["content"]
    )
    redirect to '/'
end


get '/signup' do
  erb :signup
end

get '/register' do
  User.create(
    :email => params["email"],
    :password => params["password"]
    )
    redirect to '/'
end

get '/admin' do
  @users = User.all
  erb :admin
  #모든 유저를 불러와
  #admin.erb에서 모든 유저를 보여준다.
end

get '/login' do
  erb :login
end

get '/login_session' do
  if User.first(:email => params["email"])
    if User.first(:email => params["email"]).password == params["password"]
      session[:email] = params["email"]
      @message = "Login Completed!"
    else
      @message = "Login failed"
    end
    else
      @message = "There is no user in our database!"
    end
    erb :login_session
end


get '/logout' do
  session.clear
  redirect to '/'
end
