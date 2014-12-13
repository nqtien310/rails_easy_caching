require "rails_easy_caching/version"
require 'configuration'

module RailsEasyCaching
  extend ActiveSupport::Concern

  module ClassMethods
    def cached(key, options = {})
      define_method "cached_#{key}" do
        if RailsEasyCaching.configuration.test_exclude?
          cache_data(key, options[:attrs])
        else
          Rails.cache.fetch(cache_key(key)) do
            cache_data(key, options[:attrs])
          end
        end
      end

      define_method "clear_cached_#{key}" do
        if !RailsEasyCaching.configuration.test_exclude?
          Rails.cache.delete(cache_key(key))
        end
      end
    end
  end

  def cache_key(key)
    "#{self.class.to_s.downcase}_#{id}_#{key}"
  end

  def cache_data(key, attrs = nil)
    records = reload.send(key)
    records = records.to_a if records.is_a?(ActiveRecord::Relation)

    if attrs.nil?
      records
    else
      records.map do |record|
        hash_data = Hash[attrs.map {|att| [att, record.send(att)]}]
        OpenStruct.new(hash_data)
      end
    end
  end

  class << self
    def config
      yield(configuration)
    end

    def configuration
      @@configuration ||= Configuration.new
    end
  end
end
