module Api
  class FriendshipSerializer
    include JSONAPI::Serializer
    attributes :id, :created_at, :updated_at

    belongs_to :user
    belongs_to :friend, serializer: Api::UserSerializer
  end
end
