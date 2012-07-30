require 'rubygems'
#require 'require_relative'
require 'sinatra'
require 'data_mapper'
require 'active_support/secure_random'
require 'active_support/core_ext'
require 'erb'
require 'json'
require 'redis'
require 'rack-datamapper-session'
require './quote'
require './page'
require './user'
require './auth'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/stone.db")

DataMapper.finalize
Quote.auto_upgrade!
Page.auto_upgrade!
User.auto_upgrade!
Rack::Session::DataMapperSession.auto_upgrade!

$redis = Redis.new(:host => "localhost", :port => 6379)

class MyApp < Sinatra::Base
  include Auth

  set :static, true
  set :views,  File.dirname(__FILE__) + '/public'
  set :public_folder, Dir.pwd + '/public'
  use Rack::Session::DataMapper, :expire_after => 1.day

  get '/page' do
     @page = Page.get(params[:id])

     css  = "<style type='text/css'> .QuotedSpace { background: #F5ED7F; } </style>"
     base = "<base href='http://#{@page.host}' />"
     js = "<script src='http://localhost:8000/js/edit_page.js'></script>"
     body base + css + js + @page.to_s
  end

  get '/' do
    if  logged_in?
      @pages = current_user.pages
      erb :'index.html'
    else
      send_file 'public/auth.html'
    end
  end

  get '/iframe' do
    headers 'Access-Control-Allow-Origin' => '*'
    headers 'X-Frame-Options' => ''

    if logged_in?
      @data  = JSON.parse($redis.get(params[:id]))
      html = @data['html']
      @page = Page.create(:user_id => current_user.id, 
                           :source_url => @data['source_url'], 
                           :host => @data['host'], 
                           :html => html,
                           :title => @data['title'])

      p "DEBUG"
      p @page.valid? 
      p @page.errors.values
      erb :'/iframe/index.html'
    else
      send_file 'public/iframe/auth.html'
    end
  end

  get '/widget' do
    send_file 'public/js/widget.js'
  end

  post '/auth' do
    headers 'Access-Control-Allow-Origin' => '*'

    if logged_in?
      session[:user_id] = current_user.id
      body 'auth ok'
    else
      user = User.create(params[:user])
      if user.saved?
        session[:user_id] = current_user.id
        body 'auth ok'
      else
        body JSON.generate(user.errors.to_hash)
      end
    end
  end

  options '/' do
    headers 'Access-Control-Allow-Origin' => '*',
            "Access-Control-Max-Age" => "600",
            'Access-Control-Allow-Methods' => "POST, GET, OPTIONS",
            'Access-Control-Allow-Headers' => "Content-Type"
    body '' 
  end
  
  post '/' do
    key  = SecureRandom.hex(16)
    data = request.env["rack.input"].read

    $redis.set(key, data)
    $redis.expire(key, 10)

    headers 'Access-Control-Allow-Origin' => '*'
    body key
  end
end

MyApp.run! :port => 8000
