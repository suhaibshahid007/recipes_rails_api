class RecipesCollection
  attr_reader :params

  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def call
    filter_by_title if params[:title].present?
    filter_by_difficulty if params[:difficulty].present?
    filter_by_time if params[:time].present?

    @relation
  end

  private

  def filter
    @relation = yield(@relation)
  end

  def filter_by_title
    filter { @relation.where('title iLIKE ?', params[:title]) }
  end

  def filter_by_difficulty
    filter { @relation.where(difficulty: params[:difficulty]) }
  end

  def filter_by_time
    filter { @relation.where('time iLIKE ?', params[:time]) }
  end
end
