require 'grackle'
require 'couchbase/model'

class Tweets < Couchbase::Model

  HIPSTER = "rbin"
  attribute :doctype
  attribute :content
  attribute :tweet_id
  attribute :created
  
  uuid_algorithm :random

  view :by_id, :by_timestamp
   
  def self.get_timeline
    tweets = client.statuses.home_timeline? :screen_name => HIPSTER #http://api.twitter.com/1/statuses/home_timeline.json
    tweets.each do |t|
      created = DateTime.parse(t.created_at)      
      tweet_id = t.id_str.to_i
      # create the tweet if it doesn't already exist
      unless Tweets.exists?("tw::#{tweet_id}")
        Tweets.create({:id => "tw::#{tweet_id}", :doctype => "tweet", :content => t.text, :tweet_id => tweet_id, :created => created.getutc.to_i })
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
