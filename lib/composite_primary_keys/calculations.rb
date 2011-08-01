module ActiveRecord
  module Calculations
    alias :execute_simple_calculation_ar :execute_simple_calculation
    def execute_simple_calculation(operation, column_name, distinct)
      # CPK
      if column_name.kind_of?(Array)
        projection = self.primary_keys.map do |key|
          attribute = arel_table[key]
          self.arel.visitor.accept(attribute)
        end.join(', ')
        execute_simple_calculation_ar(operation, projection, distinct)
      else
        execute_simple_calculation_ar(operation, column_name, distinct)
      end
    end
  end
end
