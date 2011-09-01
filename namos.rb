require 'rubygems'
require 'sinatra'
require "sinatra/reloader"
require 'erb'


def index
    @useri = User.all
  end


  def show
    @user = User.find(params[:id])

  end



  def new
    @user = User.new

  end



  def edit
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end



  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy

end





enable :logging, :dump_errors, :raise_errors

DB = []
DB << {:name => 'Anton', :sex => 'M',  :tags => ['Haker', 'joker']}
DB << {:name => 'Viktor', :tags => ['Ruby', 'Java']}


get '/' do
  @users = DB

  erb :'note_book/index'
end

get '/new' do
  erb :'note_book/new.html'
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




