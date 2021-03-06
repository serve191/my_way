require 'rubygems'
require 'sinatra'
require "sinatra/reloader"
require 'erb'
require 'yaml'

enable :logging, :dump_errors, :raise_errors

DB = []

p "start"
f = File.open('db.txt')
if 0 < (data = f.read).length 
  DB += YAML::load(data)
end

get '/' do
  @users = DB

  if params[:search]
    if params[:search][:name] != ""
      @users = @users.find_all{|u| u[:name] == params[:search][:name]} 
    end

    if params[:search][:age] != ""
      @users = @users.find_all{|u| 
        if params[:search][:age_type] == '>'
          u[:age].to_i > params[:search][:age].to_i
        elsif params[:search][:age_type] == '<'
          u[:age].to_i < params[:search][:age].to_i
        else
          u[:age] == params[:search][:age]
        end
      } 
    end
  end

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

  DB << params[:user] 
  f = File.open('db.txt', "w")
  f.write(DB.to_yaml)
  f.close

  redirect '/'
end
