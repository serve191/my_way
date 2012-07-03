require 'rubygems'
require 'require_relative'
require 'sinatra'
require 'data_mapper'
require 'erb'
require './quote'
require './user'
require './auth'
require './session'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/stone.db")

DataMapper.finalize
Quote.auto_upgrade!
User.auto_upgrade!

class MyApp < Sinatra::Base
  include Auth

  set :static, true
  set :public, File.dirname(__FILE__) + '/public' 

  get '/' do
    if logged_in?
      send_file 'public/index.html'
    else
      send_file 'public/auth.html'
    end
  end

  get '/window' do
    send_file 'public/window.html'
  end

  get '/widget' do
    send_file 'public/js/widget.js'
  end

  post '/auth' do
    if logged_in?
      session[:user_id] = current_user.id
    else
      user = User.new(params[:user])
      if user.save
        session[:user_id] = current_user.id
      end
    end

    redirect '/'
    #headers 'Access-Control-Allow-Origin' => '*'
  end

  post '/' do
    p 'DEBUG - ' * 10
    p params[:quote]
    p params[:source_url]

    if logged_in?
       quote = Quote.new(:body => params[:quote], :source_url => params[:source_url])
       quote.save
     end
  end
end

MyApp.run! :port => 8000
