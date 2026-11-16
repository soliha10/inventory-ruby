%w[Equipement Furniture Book Document Other].each { |name| Category.find_or_create_by!(name:)}
User.find_or_create_by!(email:"admin@example.com") do |user|
  user.assign_attributes(name: "Admin", password: "password", admin:true)
end