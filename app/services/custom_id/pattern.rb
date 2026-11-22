module CustomId
  class Pattern
    FIXED_PARTS ={"guid"=>"\\h{8}-\\h{4}-\\h{4}-\\h{4}-\\h{12}", "datetime" => ".+?"}.freeze
    def initialize(elements)=@elements=elements
    def match?(custom_id) = @elements.empty? || regexp.match?(custom_id.to_s)
    private
    def regexp =Regexp.new("\\A#{@elements.map { |element| part(element) }.join}\\z")
    def part(element)=element.kind == "text" ? Regexp.escape(element.value) : FIXED_PARTS.fetch(element.kind) {NumberFormat.new(element.value).regex}
  end
end