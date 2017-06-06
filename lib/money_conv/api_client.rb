require 'httparty'

module MoneyConv
  class ApiClient
    include HTTParty
    base_uri 'apilayer.net/api'

    attr_reader :options

    def initialize(token)
      @options = { query: { access_key: token } }
    end

    def currencies
      list.parsed_response['currencies']
    end

    def convert(amount, from, to)
      to_usd = Rational(1, rates["USD#{from}"])
      amount = Rational(amount)
      usd_to = Rational(rates["USD#{to}"])
      Float(amount * to_usd * usd_to)
    end

    def rates
      @rates ||= usd_rates.parsed_response['quotes']
    end

    private

    def check_errors(response)
      if response.parsed_response['success']
        return response
      elsif response.parsed_response.nil?
        Utils.error "Coud not connect to server"
      else
        Utils.error "Is your access key correct?"
      end

      exit 1
    end

    def usd_rates
      check_errors self.class.get("/live", options)
    end

    def list
      check_errors self.class.get("/list", options)
    end
  end
end
