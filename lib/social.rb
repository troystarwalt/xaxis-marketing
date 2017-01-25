module Social
  require 'yaml'

  # We connect to Twitter with this. After connecting, we move to storeTweets
  def self.connectTwitter
    # Get the last four tweets on the timeline.
    tweets = $twitter.user_timeline('Xaxistweets', count: 4)
    puts "connecting twitter"
    # Send the tweets to storeTweets
    storeTweets(tweets)
  end

  # Start of the Twitter Call
  def self.getTweets
    # First check if the file exisits.
    if File.exist?(Rails.root + 'lib/tweets.yml')
      # Since it is, we are going to find out when the file was created.
      check_file = File.open(Rails.root + 'lib/tweets.yml')
      if check_file.birthtime < Time.now - 1.hour
        # If it is older than an hour, then we'll connectTwitter
        puts "it's an old file so we'll create a new one to use"
        connectTwitter
      else
        # If it was created less than an hour ago, then we'll just collectTweets
        puts "it's a new file, so we'll grab the shit we already have"
        collectTweets
      end
    else
      # The file doesn't exist, so we'll connectTwitter
      puts "tweets don't exist so we'll connect to twitter and create the tweets"
      connectTwitter
    end
  end

  # Store the tweets in a YAML file.
  def self.storeTweets(returned_tweets)
    File.write(Rails.root + 'lib/tweets.yml', YAML.dump(returned_tweets))
    puts "storeTweets"
    collectTweets
  end

  # Final step to return those tweets to the PostsController
  def self.collectTweets
    puts "grabbing those tweets"
    YAML.load_file(Rails.root + 'lib/tweets.yml')
  end

  def self.force_update_twitter_warning
    time = Time.now.localtime
    last_updated_time = File.open(Rails.root + 'lib/tweets.yml').birthtime.localtime
    minutes_since_update = ((time - last_updated_time) / 60).to_i
    output_string = "Are you sure? The last update was at #{File.open(Rails.root + 'lib/tweets.yml').birthtime.localtime}, only #{minutes_since_update} minutes ago. Forcing updates my result in Twitter blocking our site."
  end
end
