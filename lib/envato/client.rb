require 'envato/connection'
require 'envato/configurable'
require 'envato/client/stats'
require 'envato/client/user'
require 'envato/client/catalog'

module Envato
  class Client

    include Envato::Connection
    include Envato::Configurable
    include Envato::Client::Stats
    include Envato::Client::User
    include Envato::Client::Catalog

    def initialize(options = {})
      Envato::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Envato.instance_variable_get(:"@#{key}"))
      end

      if @access_token.nil?
        raise Envato::MissingAPITokenError, 'You must define an API access token for authorization.'
      end
    end

    def inspect
      inspected = super

      if @access_token
        inspected = inspected.gsub! @access_token, conceal(@access_token)
      end

      inspected
    end

    # Conceal a sensitive string.
    #
    # This conceals everything in a string except for the first and last 4
    # characters. Useful to hide sensitive data without removing it completely.
    #
    # @example Concealing a string over 8 characters.
    #   conceal('secretstring')
    #   # => 'secr****ring'
    # @example Concealing a string under 8 characters.
    #   conceal('tester')
    #   # => '****'
    #
    # @param string [String] String you wish to conceal.
    # @return [String] Concealed version of the string.
    def conceal(string)
      if string.length < 8
        '****'
      else
        front = string[0, 4]
        back  = string[-4, 4]
        "#{front}****#{back}"
      end
    end

    private

    # All 'known' marketplace names we wish to allow querying via.
    #
    # @return [Array] Marketplace names we wish to whitelist.
    def marketplace_names
      %w(graphicriver themeforest activeden codecanyon videohive audiojungle photodune 3docean)
    end

    # Domain versions of the marketplace names.
    #
    # @return [Array] Marketplace domains including the TLD.
    def marketplace_domains
      marketplace_names.map { |domain| "#{domain}.net" }
    end
  end
end
