require 'data_mapper'

class Quote 
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :body, Text
    property :source_url, String 
    property :created_at, DateTime

end
