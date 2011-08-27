require 'spree_core'
require 'spree_multi_vendor_hooks'
require 'spree_multi_vendor/configuration'

module Spree::MultiVendor
  Config = Spree::MultiVendor::Configuration.configure do |config|
    config.database_prefix = "ecommerce_"
    config.adapter = "mysql2"
    config.host = "localhost"
    config.username = "root"
    config.password = ""
  end
end

module SpreeMultiVendor
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end