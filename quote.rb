require 'data_mapper'
require 'dm-types'

class Quote 
    include DataMapper::Resource

    property :id, Serial
    property :user_id, Integer 
    property :title, String
    property :body, Text
    property :html, Text, :lazy => true
    property :source_url, Text
    property :host, String 
    property :anchor, String 
    property :obj, Json 
    property :created_at, DateTime

    class << self

    end
end
