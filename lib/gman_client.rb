require 'gman_client/api/orders'
require 'gman_client/commodity_merchandising/contracts'
require 'gman_client/utility'
require 'gman_client/version'
require 'gman/client'
require 'rest_client'
require 'json'
require 'blanket'
require 'hashie'
require 'retries'

module GmanClient
  def self.root
    File.expand_path '../..', __FILE__
  end
end
