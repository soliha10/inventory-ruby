class InventoryStats
AGGREGATES =  {"number" => %w[avg min max], "string" => %w[mode]}.freeze 
def initialize(inventory)
@items = inventory.items
@fields = inventory.fields.select { |field| AGGREGATES.key?(field.kind) }
end
def items_count = @items.count
def rows
    values = aggregate_values.each
    @fields.map {|field| [field, AGGREGATES[field.kind].index_with {values.next}] }   
end
private 
def aggregate_values = @fields.empty? ? [] : Array.wrap(@items.pick(*expressions))

  def expressions = @fields.flat_map {|field| AGGREGATES[field.kind].map {|name| sql(name, field.column)}}
  def sql(name, column) = Arel.sql(name == "mode" ? "mode() WITHIN GROUP (ORDER BY #{column})" : "#{name}(#{column})" ) 
end