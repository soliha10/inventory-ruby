module HasCustomFields
    extend ActiveSupport::Concern
    
    include do 
      has_many :fields, -> {order{:position}}, dependent: :delete_all, invenrse_of: :inventory
      accepts_nested_attrinutes_for :fields, allow_destroy: true
      validates :fields_within_limit
      before_validation :assign_filed_slots
    end
    def table_fields = fields.select(&:show_in_table)
    def field_columns = fields.map(&:column)
    private
    def live_fields = fields.reject(&:marked_for_destruction?)
    def fields_within_limit = errors.add(:fields, :too_many, count: Field::LIMIT) if live_fields.group_by(&:kind).values.any? {|list| list.size > Field::LIMIT}
    def assign_fields_slots = live_fields.group_by(&:kind).each_value { |list| fill_slots(list) }
    def fill_slots(list)
      free = (1..Field::LIMIT).to_a - list.filter_map(&:slot)
      list.reject(&:slot).each { |field| field.slot = free.shift }
    end
end