class User < ApplicationRecord
  LOCALES = %w[en uz].freeze
  THEMES = %w[light dark].freeze
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 github]
  has_many :inventories, foreign_key: :creator_id, dependent: :destroy, inverse_of: :creator
  has_many :accesses, dependent: :delete_all
  has_many :writable_inventories, through: :accesses, source: :inventory
  validates :name, presence: true
  validates :locale, inclusion: {in: LOCALES}
  validates :theme, inclusion: {in: THEMES}

  scope :matching, ->(term) {where("name ILIKE :q OR email ILIKE :q", q: "#{sanitize_sql_like(term.to_s)}%")}
  def self.from_omniauth(auth)
    find_by(provider: auth.provider, uid: auth.uid) || find_by(email: auth.info.email) || create_from_omniauth!(auth)
  end

  def self.create_from_omniauth!(auth)
    create!(provider: auth.provider, uid: auth.uid, name: auth.info.name.presence || auth.info.nickname,
            email: auth.info.email || "#{auth.uid}@#{auth.provider}.oauth", password: Devise.friendly_token)
  end

  def active_for_authentication? =super && !blocked?
  def inactive_message = blocked? ? :blocked : super
  def self.ransackable_attributes(_auth = nil) = %w[name email]

end