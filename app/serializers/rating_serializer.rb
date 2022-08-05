class RatingSerializer < BaseSerializer
  attributes :id, :score

  belongs_to :user
  belongs_to :recipe
end
