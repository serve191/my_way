require 'data_mapper'
require 'dm-types'

class User
    include DataMapper::Resource

    property :id, Serial
    property :login, String, :required => true, :unique => true, :length => 1..20
    property :email, String, :unique => true, :format => :email_address
    property :password, BCryptHash, :required => true, :length => 5..1000
    property :created_at, DateTime
    property :oauth_token,  String 
    property :oauth_secret, String 

    has n, :quotes
    has n, :pages

end
