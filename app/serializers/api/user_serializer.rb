module Api
  class UserSerializer < BaseSerializer
    enable_caching

    attributes :id, :name, :created_at, :updated_at
  end
end
