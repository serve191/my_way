require 'rubygems'
require 'require_relative' 
require 'sinatra'
require 'erb'

  module Gothonweb

class MyApp < Sinatra::Base
      # Я в области видимости приложения!
      set :foo, 42
      foo # => 42
      
      get '/foo' do
        # Я больше не в области видимости приложения!
      end
    end
  
    get '/' do
      greeting = "Hello, World!"
      erb :index, :locals => {:greeting => greeting}
   end
   
   get '/hello' do
     erb :hello_form
   end
 
   post '/hello' do
     greeting = "#{params[:greet] || "Hello"}, #{params[:name] || "Nobody"}"
     erb :index, :locals => {:greeting => greeting} 
   end
 
 end

get '/foo' do
    request.body              # тело запроса, посланное клиентом (см. ниже)
    request.path_info         # "/foo"
    request.port              # 80
    request.host              # "example.com"
    request.url               # "http://example.com/example/foo"
    request.path              # "/example/foo"
    request.ip                # IP-адрес клиента
  end
