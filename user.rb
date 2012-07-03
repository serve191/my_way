require 'data_mapper'
require 'dm-types'

class User
    include DataMapper::Resource

    property :id, Serial
    property :login, String, :unique => true
    property :email, String, :required => true, :unique => true, :format => :email_address
    property :password, BCryptHash, :required => true
    property :created_at, DateTime
    property :oauth_token,  String 
    property :oauth_secret, String 

end
