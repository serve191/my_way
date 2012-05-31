require 'rubygems'
require 'require_relative'
require 'sinatra'
require 'erb'
require './quote'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/stone.db")

DataMapper.finalize
Quote.auto_upgrade!

class MyApp < Sinatra::Base
    set :static, true
    set :public, File.dirname(__FILE__) + '/public' 

    get '/' do
      send_file 'public/index.html'
   end

   post '/' do
       p 'DEBUG - ' * 10
       p params[:quote]
       p params[:source_url]

       quote = Quote.new(:body => params[:quote], :source_url => params[:source_url])
       quote.save
   end

end

MyApp.run!
