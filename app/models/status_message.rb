class StatusMessage < ActiveRecord::Base
  attr_accessible :text, :language, :tweet_id, :tweet_screen_name, :tweet_created_at
   attr_accessible :created_at

  validates :text, :presence => true, :length => {:minimum => 1, :maximum => 254}
  validates :language, :presence => true, :length => {:minimum => 2, :maximum => 40}
  translates :text, :language, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale
  end

  def self.get_recent

  	# get recent cashed message or tweet
  	message = StatusMessage.find(:first, :order => "id DESC")
  	return if message.blank?

    # check if there is a more recent tweet
    new_tweet = pull_recent_tweet
    return message if new_tweet.blank?

    recent_message = compare_creation_date(message, new_tweet)
    return recent_message

    # if new_tweet and new_tweet.tweet_created_at > message.tweet_created_at
    #   message = new_tweet
    # end

  	# if message.tweet_id.blank?
  	# 	# message is normal message, get cached tweet
  	# 	tweet = StatusMessage.find(:first, :conditions => ["tweet_id != ?", ""], :order => "id DESC")
  		
  	# 	# check if tweet is expired
  	# 	if tweet.nil? or tweet.expired? 
  	# 		new_tweet = self.pull_recent_tweet
  	# 		# check if there is a newer tweet
  	# 		if new_tweet and new_tweet.tweet_created_at > message.created_at
  	# 			message = new_tweet
  	# 		end
  	# 	else
  	# 		# cached tweet is not expired and can be used
  	# 		message = tweet
  	# 	end 
  	# else
  	# 	# message is a tweet, check if tweet is expired
  	# 	if message.expired?
			# 	# check if there is a newer tweet
			# 	new_tweet = self.pull_recent_tweet
			# 	if new_tweet and new_tweet.tweet_created_at > message.tweet_created_at
  	# 			message = new_tweet
  	# 		end
  	# 	end
  	# end
  	# return message
  end

  # def expired?
  # 	if self.tweet_id.nil? or self.tweet_id.blank?
  # 		# not a tweet
  # 		return false
  # 	end
  # 	if self.created_at < (Time.now - Settings.cache.status_message_expires_in.minutes)
  # 		return true
  # 	else
  # 		return false 
  # 	end
  # end

private

  def self.compare_creation_date(message1, message2)
    if message1.tweet_id.blank? and message2.tweet_id.present?
      # normal message and a tweet
      if message1.created_at >= message2.tweet_created_at
        recent_message = message1
      else
        recent_message = message2
      end
    elsif message1.tweet_id.present? and message2.tweet_id.present?
      # two tweets
      if message1.tweet_created_at >= message2.tweet_created_at
        recent_message = message1
      else
        recent_message = message2
      end
    end  
    return recent_message
  end

  def self.pull_recent_tweet
    tweet = get_tweet

  	# save tweet to db if it is not cached yet
  	if tweet.blank? or exists?(:tweet_id => tweet.id.to_s) 
      return nil
    end
		# tweets are assumed to be German
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

  def self.get_tweet
    if Rails.env.test?
      return nil
    end
    begin
      tweet = Twitter.user_timeline(Settings.twitter.user, :count => 1).first
    rescue
      return nil
    end
    return tweet
  end
end
