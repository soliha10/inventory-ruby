%w[Equipment Furniture Book Document Other].each { |name| Category.find_or_create_by!(name:)}
return if ENV["ADMIN_EMAIL"].blank? || ENV["ADMIN_PASSWORD"].blank?

User.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |user|
  user.assign_attributes(name: "Admin", password: ENV["ADMIN_PASSWORD"], admin: true)
end