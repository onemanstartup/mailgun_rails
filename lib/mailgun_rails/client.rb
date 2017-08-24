require 'faraday'

module MailgunRails
  class Client
    attr_reader :api_key, :domain, :verify_ssl

    def initialize(api_key, domain, verify_ssl = true)
      @api_key    = api_key
      @domain     = domain
      @verify_ssl = verify_ssl
    end

    def send_message(options)
      connection = Faraday.new(url: api_url) do |faraday|
        faraday.request :multipart
        faraday.adapter  Faraday.default_adapter
      end

      connection.basic_auth('api', api_key)

      connection.post('messages', options)
    end

    def api_url
      "https://api:#{api_key}@api.mailgun.net/v3/#{domain}"
    end
  end
end
