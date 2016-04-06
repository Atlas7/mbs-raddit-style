class Api::V1::EntrySerializer < ActiveModel::Serializer
  attributes :id, :user_id, :category_id, :medium_id, \
   :cached_votes_total, :cached_votes_score, :cached_votes_up, \
   :cached_votes_down, :quote, :picture, \
   :created_at, :updated_at
end