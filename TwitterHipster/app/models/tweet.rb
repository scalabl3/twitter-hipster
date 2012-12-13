require 'grackle'
require 'couchbase/model'

class Tweet < Couchbase::Model

  HIPSTER = "rbin"
  attribute :content
  attribute :created
  
  uuid_algorithm :random
  
  def self.get_latest
    tweets = client.statuses.user_timeline? :screen_name => HIPSTER # hit the API
    tweets.each do |t|
      created = DateTime.parse(t.created_at)
        unless Tweet.exists?(["created=?", created.to_i])
        Tweet.create({:content => t.text, :created => created.to_i })
       end
    end
  end
  
  private
  def self.client
    Grackle::Client.new(:auth=>{
      :type=>:oauth,
      :consumer_key=>'P5iDj6rQL0Zx6ooDgrKMg',
      :consumer_secret=>'9Znpz8qQ0dIOoqz96tyeuXfqW6g5miHZu2rGKpKuPRs',
      :token=>"145237874-BThPiQ80HfSD5tnquOCq9HIstKEi5JXOAeUVwuOC",
      :token_secret=>"yVZY6r2R3znNJsmYSzZ13TfSA0uiOphqtwr6grjTjI"
    })

  end
end
