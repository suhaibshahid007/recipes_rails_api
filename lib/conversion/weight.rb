module Conversion
  class Weight
    attr_reader :weight, :from_unit, :to_unit, :result

    def initialize(weight, from_unit, to_unit)
      @weight = weight
      @from_unit = from_unit
      @to_unit = to_unit
    end

    private

    def to_kg
      case from_unit.to_sym
      when :g then weight.to_f / 1_000.0
      when :mg then weight.to_f / 1_000_000.0
      else
        "Conversion not available from #{from_unit} to #{to_unit}"
      end
    end

    def to_g
      case from_unit.to_sym
      when :kg then weight.to_f * 1_000.0
      when :mg then weight.to_f / 1_000.0
      else
        "Conversion not available from #{from_unit} to #{to_unit}"
      end
    end

    def to_mg
      case from_unit.to_sym
      when :kg then weight.to_f * 1_000_000.0
      when :g then weight.to_f * 1_000.0
      else
        "Conversion not available from #{from_unit} to #{to_unit}"
      end
    end
  end
end
