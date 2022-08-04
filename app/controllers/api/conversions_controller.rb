class Api::ConversionsController < Api::BaseController
  def weight
    result = ConversionService.new.convert_weight(params[:weight], params[:from_unit], params[:to_unit])
    render json: result, status: result.status
  end
end
