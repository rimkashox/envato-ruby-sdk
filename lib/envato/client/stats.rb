module Envato
  class Client
    module Stats
      # Get a total user count across all the marketplaces.
      #
      # @see https://build.envato.com/api/#market_TotalUsers
      #
      # @example Finding all users.
      #   @client.total_users
      #
      # @return [Integer] Total count of all users.
      def total_users
        get 'v1/market/total-users.json'
      end

      # Get a total item count across all the marketplaces.
      #
      # @see https://build.envato.com/api/#market_TotalItems
      #
      # @example Finding all items.
      #   @client.total_items
      #
      # @return [Integer] Total count of all items.
      def total_items
        get 'v1/market/total-items.json'
      end

      # Retrieve category information for a marketplace.
      #
      # @see https://build.envato.com/api/#market_NumberOfFiles
      #
      # @example Getting all category information for themeforest.net
      #   @client.category_information_by_site('themeforest')
      #
      # @param sitename [String] Marketplace name.
      # @raise [Envato::InvalidSiteName] If marketplace name is not valid.
      # @return [Array] With inner hashes containing all the specific category
      #   information for the requested marketplace.
      def category_information_by_site(sitename)
        raise Envato::InvalidSiteName unless marketplace_names.include? sitename

        get "v1/market/number-of-files:#{sitename}.json"
      end
    end
  end
end
