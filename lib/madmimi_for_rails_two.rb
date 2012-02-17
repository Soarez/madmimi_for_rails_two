class MadMimi
  BASE_URL = 'api.madmimi.com'
  STATUS_PATH = '/mailers/status'
  SEND_PATH = '/mailer'
  cattr_accessor :api_settings
  
  def self.is_transactional
    api_settings[:transactional].nil? || api_settings[:transactional] == true
  end
  
  def self.username
    api_settings[:username]
  end
  
  def self.api_key
    api_settings[:api_key]
  end
  
  def self.check_status(transaction_id)
    return if transaction_id.nil?
    return unless is_transactional
    
    connection.get("#{STATUS_PATH}/#{transaction_id}?username=#{username}&api_key=#{api_key}").body
  end
  
  def self.connection
    http = Net::HTTP.new(BASE_URL, is_transactional ? 443 : 80)

    if is_transactional
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    
    http
  end
end

class TMail::Mail
  
  attr_accessor :transaction_id

  def check_madmimi_status
    MadMimi.check_status(transaction_id)
  end
end

class ActionMailer::Base
  
  adv_attr_accessor :promotion_name
  
  def perform_delivery_madmimi(mail)  
    
    form_data = { 
      'username' => MadMimi.username,
      'api_key' => MadMimi.api_key,
      'promotion_name' => promotion_name, 
      'recipients' => recipients,
      'from' => from, 
      'subject' => subject,
      'reply_to' => reply_to,
      'raw_html' => body + ' [[tracking_beacon]]'
    }
    
    http = MadMimi.connection
    
    begin
      http.start do |http|
        request = Net::HTTP::Post.new(MadMimi::SEND_PATH)
        request.set_form_data(form_data)
        response = http.request(request)
        mail.transaction_id = response.body.strip
      end
    rescue SocketError
      raise "Host unreachable."
    end
  end
end