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

post '/logout' do
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

post '/users/new' do # CREATE
  @user = User.new(first: params['first'], last: params['last'], email: params['email'], password: params['password'], birthday: params['birthday'], icon: params['icon'], color: params['color'])
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

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'users/profile'
end

post '/users/:id' do # DELETE
  user = User.find(session[:user_id])
  if params['password'] == user.password
    user_articles = Article.where(user_id: user.id)
    user_articles.each do |article|
      article.update(user_id: nil)
    end
    user.destroy
    session[:user_id] = nil
  else
    puts "Incorrect password"
    redirect "users/#{user.id}"
  end
  redirect '/'
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

get '/articles/new' do # READ
  if session['user_id'] == nil
    p 'Log in or create an account.'
    redirect '/'
  end
  erb :'/articles/new'
end

post '/articles/new' do # CREATE
  user_image = params['image']
  if user_image == ""
    image = 'https://vignette.wikia.nocookie.net/crypt-of-the-necrodancer/images/f/fc/Nintendo_Switch_icon.png/revision/latest?cb=20180517200137'
  else
    image = params['image']
  end
  @article = Article.new(title: params['title'], image: image, content: params['content'], user_id: session['user_id'])
  @article.save
  redirect "users/#{@article.user_id}"
end

get '/articles/:id' do
  @article = Article.find(params[:id])
  erb :'articles/article'
end

post '/articles/:id' do # DELETE
  @article = Article.find(params[:id])
  @article.destroy
  redirect "/users/#{session[:user_id]}"
end

get '/articles/?' do
  @articles = Article.last(20)
  erb :'articles/index'
end
