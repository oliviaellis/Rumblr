require 'sinatra'
require 'sinatra/activerecord'

enable :sessions

if ENV['RACK_ENV']
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  set :database, {adapter: "sqlite3", database: "database.sqlite3"}
end

class User < ActiveRecord::Base
  has_many :articles
end

class Article < ActiveRecord::Base
  belongs_to :user
end

get '/' do
  erb :home
end

get '/login' do
  erb :home
end

post '/login' do
  user = User.find_by(email: params['email'])
  if user != nil
    if user.password == params['password']
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect '/login'
    end
  else
    redirect '/login'
  end
end

post '/logout' do # DELETE
  session['user_id'] = nil
  redirect '/'
end

get '/users/new' do # READ
  if session['user_id'] != nil
    p 'User is already logged in.'
    redirect '/'
  end
  erb :'/users/new'
end

get '/articles/new' do # READ
  if session['user_id'] == nil
    p 'Log in or create an account.'
    redirect '/'
  end
  erb :'/articles/new'
end

post '/users/new' do # CREATE
  @user = User.new(first: params['first'], last: params['last'], email: params['email'], password: params['password'], birthday: params['birthday'])
  find_user = User.find_by(email: params['email'])
  if find_user == nil
    @user.save
  else
    p "User already exists."
    redirect '/'
  end
  session[:user_id] = @user.id
  redirect "users/#{@user.id}"
end

post '/articles/new' do # CREATE
  @article = Article.new(title: params['title'], content: params['content'], user_id: session['user_id'])
  @article.save
  redirect "users/#{@article.user_id}"
end

# Below should be a delete request, but Sinatra doesn't support them.

post '/users/:id' do # DELETE
  user = User.find(session[:user_id])
  if params['password'] == user.password
    user.destroy
    session[:user_id] = nil
  else
    puts "Incorrect password"
    redirect "users/#{user.id}"
  end
  redirect '/'
end

post '/articles/:id' do # DELETE
  @article = Article.find(params[:id])
  @article.destroy
  redirect "/users/#{session[:user_id]}"
end

get '/articles/?' do
  @articles = Article.all.order('created_at DESC').take(20)
  erb :'articles/index'
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'users/profile'
end

get '/users/:id/edit' do
  erb :'users/edit'
end

post '/users/:id/edit' do
  user = User.find(params[:id])
  if params['password'] == user.password
    user.update(first: params['first'], last: params['last'], email: params['email'], password: user.password, birthday: params['birthday'])
    redirect "/users/#{user.id}"
  else
    puts "Incorrect password"
    redirect "/users/#{user.id}/edit"
  end
end
