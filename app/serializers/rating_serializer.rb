class RatingSerializer < BaseSerializer
  attributes :score

  belongs_to :user
  belongs_to :recipe
end
