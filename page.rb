class Page
  include DataMapper::Resource

  property :id, Serial
  property :user_id, Integer 
  property :title, String
  property :html, Text, :lazy => true
  property :source_url, Text
  property :host, String 
  property :created_at, DateTime


  def to_s
    html
  end

end
