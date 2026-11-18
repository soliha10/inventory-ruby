module HasCustomId
extend ActiveSupport::Concern
ELEMENTS_LIMIT=10
included do 
  has_many :id_elements, -> {order(:position)}, dependent: :delete_all, inverse_of: :inventory
  accepts_nested_attributes_for :id_elements, allow_destroy: true

  validate :id_elements_within_limit
end
def live_id_elements = id_elements.reject(&:marked_for_destruction?).sort_by(&:position)
def next_sequence = items.maximum(:sequence_number).to_i+1
def generate_custom_id(sequence = next_sequence)=CustomId::Generator.new(live_id_elements, sequence).generate
def custom_id_format = CustomId::Pattern.new(live_id_elements)
private
def id_elements_within_limit
  errors.add(:id_elements, :too_many, count: ELEMENTS_LIMIT) if live_id_elements.size > ELEMENTS_LIMIT
end
end