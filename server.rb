require 'sinatra'
require 'sinatra/activerecord'

enable :sessions

set :database, {adapter: "sqlite3", database: "database.sqlite3"}

class User < ActiveRecord::Base
  validates :first, presence: true
  validates :last, presence: true
  validates :email, uniqueness: true
  validates :password, length: { in: 6..20 }
  has_many :articles
end

class Article < ActiveRecord::Base
  belongs_to :user
end

get '/' do
  erb :home
end

get '/login' do
  erb :'/users/login'
end

post '/login' do
  user = User.find_by(email: params['email'])
  p user.password
  if user != nil
    if user.password == params['password']
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      p 'Incorrect password.'
    end
  else
    p 'Email not found.'
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
  # There's a reason we use User.new and user.save that Michael will get into later
  # It has to do with validating the input before we save it to the database.
  @user = User.new(first: params['first'], last: params['last'], email: params['email'], password: params['password'], birthday: params['birthday'])
  @user.save
  session[:user_id] = @user.id
  redirect "users/#{@user.id}"
end

post '/articles/new' do # CREATE
  @article = Article.new(title: params['title'], content: params['content'], user_id: session['user_id'])
  @article.save
  redirect "articles/#{@article.id}"
end

# Below should be a delete request, but Sinatra doesn't support them.

post '/users/:id' do # DELETE
  @user = User.find(params[:id])
  @user.destroy
  redirect '/users/?'
end

post '/articles/:id' do # DELETE
  @article = Article.find(params[:id])
  @article.destroy
  redirect '/articles/?'
end

get '/users/?' do
  @users = User.all
  erb :'users/index'
end

get '/articles/?' do
  @articles = Article.all
  erb :'articles/index'
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'users/profile'
end

get '/users/:id/edit' do
  erb :'users/edit'
end

get '/articles/:id' do
  @article = Article.find(params[:id])
  erb :'articles/article'
end
