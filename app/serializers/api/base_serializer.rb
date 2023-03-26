module Api
  class BaseSerializer
    include JSONAPI::Serializer

    def self.enable_caching
      cache_options store: Rails.cache, namespace: 'api', expires_in: 1.hour, enabled: true
    end
  end
end
