class StatusMessage < ActiveRecord::Base
  attr_accessible :text, :language, :tweet_id, :tweet_screen_name, :tweet_created_at

  validates :text, :presence => true, :length => {:minimum => 1, :maximum => 254}
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  translates :text, :language, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  def self.get_recent

  	# get recent cashed message or tweet
  	message = StatusMessage.find(:first, :order => "id DESC")
  	if !message
  		return 
  	end 
  	if message.tweet_id.blank?
  		# message is normal message, get cached tweet
  		tweet = StatusMessage.find(:first, :conditions => ["tweet_id != ?", ""], :order => "id DESC")
  		
  		# check if tweet is expired
  		if tweet.nil? or tweet.expired? 
  			new_tweet = self.pull_recent_tweet
  			# check if there is a newer tweet
  			if new_tweet and new_tweet.tweet_created_at > message.created_at
  				message = new_tweet
  			end
  		else
  			# cached tweet is not expired and can be used
  			message = tweet
  		end 
  	else
  		# message is a tweet, check if tweet is expired
  		if message.expired?
				# check if there is a newer tweet
				new_tweet = self.pull_recent_tweet
				if new_tweet and new_tweet.tweet_created_at > message.tweet_created_at
  				message = new_tweet
  			end
  		end
  	end
  	return message
  end

  def expired?
  	if self.tweet_id.nil? or self.tweet_id.blank?
  		# not a tweet
  		return false
  	end
  	if self.created_at < (Time.now - Settings.cache.status_message_expires_in.minutes)
  		return true
  	else
  		return false 
  	end
  end

  def self.pull_recent_tweet
  	if Rails.env.test?
  		return
  	end
  	begin
  		tweet = Twitter.user_timeline(Settings.twitter.user, :count => 1).first
  	rescue
  		
  	end

  	# save tweet to db if it is not cached yet
  	if tweet and !exists?(:tweet_id => tweet.id.to_s) 
  		# tweets are always in German
  		original_locale = I18n.locale
  		I18n.locale = :de
  		message = create!(
  			:language => I18n.locale,
  			:tweet_id => tweet.id,
  			:text => tweet.text,
  			:tweet_screen_name => tweet.user.screen_name,
  			:tweet_created_at => tweet.created_at)
  		I18n.locale = original_locale
  		return message
  	end
  end
end
