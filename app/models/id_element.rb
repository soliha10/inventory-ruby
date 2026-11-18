class IdElement < ApplicationRecord
 KINDS= %w[text random20 random32 random6 guid datetime sequence].freeze
 belongs_to :inventory
 validates :kind, inclusion: {in: KINDS}
end