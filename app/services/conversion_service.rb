class ConversionService
  def convert_weight(weight, from_unit, to_unit)
    Conversion::ApiResponse.new(Conversion::Weight.new(weight, from_unit, to_unit).send("to_#{to_unit}"), :ok)
  rescue NoMethodError => e
    Conversion::ApiResponse.new("Conversion to '#{to_unit}' not available. Available options are kg, mg and g.", :bad_request)
  end
end
