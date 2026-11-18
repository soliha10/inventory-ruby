module CustomId
class Generator
 RANDOM_RANGES={"random20"=>2**20, "random32"=>2**32, "random6"=>10**6, "random9"=>10**9}.freeze
 DEFAULT_DATE_FORMAT = "%Y%m%d".freeze

 def initialize(elements, sequence)
@elements =elements
@sequence = sequence
 end
 def generate = @elements.map { |element| part(element) }.join
 private
 def part(element) = RANDOM_RANGES.key?(element.kind) ? random_part(element) : send("#{element.kind}_part", element)
 def random_part(element) = number(element, SecureRandom.random_number(RANDOM_RANGES[element.kind]))
  def sequence_part(element)=number(element, @sequence)
  def text_part(element) = element.value
  def guid_part(_element)= SecureRandom.uuid
  def datetime_part(element)=Time.current.strftime(element.value.presence ||  DEFAULT_DATE_FORMAT)
  def number(element, value) = NumberFormat.new(element.value).apply(value)
end
end