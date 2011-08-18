require 'rubygems'
require 'sinatra'
require "sinatra/reloader"
require 'erb'

enable :logging, :dump_errors, :raise_errors

DB = []
DB << {:name => 'Anton', :sex => 'M',  :tags => ['Haker', 'joker']}
DB << {:name => 'Viktor', :tags => ['Ruby', 'Java']}


get '/' do
  @users = DB

  erb :'note_book/index'
end

get '/new' do
  erb :'note_book/new'
end

post '/new' do
  p "-" * 100
  p "Debug params:"
  p params 
  p params[:user]
  p params[:user][:name]
  p "-" * 100

  redirect '/' 
end
