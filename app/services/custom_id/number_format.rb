module CustomId
class NumberFormat
SPEC = /\A(?<base>[DX]?)(?<width>\d{0,2})\z/
def initialize(spec)
 match = SPEC.match(spec.to_s.strip.upcase) || SPEC.match("")
 @hex = match[:base] == "X"
 @width = match[:width].to_i
end
def apply(number) = number.to_s(@hex ? 16 : 10).upcase.rjust(@width, "0")
def regex = "#{@hex ? '[0-9A-F]' : '\d' }{#{[@width, 1].max}}"
end
end