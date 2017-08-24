require 'faraday'


module MailgunRails
  class Client
    attr_reader :api_key, :domain, :verify_ssl

    def initialize(api_key, domain, verify_ssl = true)
      @api_key = api_key
      @domain = domain
      @verify_ssl = verify_ssl
    end

    def send_message(options)
      conn = Faraday.new do |conn|
        conn.basic_auth('api', api_key)
      end
      conn.post(mailgun_url, options)
    end

    def mailgun_url
      api_url+"/messages"
    end

    def api_url
      "https://api.mailgun.net/v3/#{domain}"
    end
  end
end
