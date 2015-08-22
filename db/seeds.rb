# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email

[:admin].each do |name|
	Role.create name: name
	puts "#{name} creado"
end

User.create name: "Admin", email: "admin@inyxtech.com", password: "12345678", password_confirmation: "12345678", role_ids: "1"
puts "admin@inyxtech.com ha sido creado"

["Clientes", "Testimonios", "Conferencias", "Galeria"].each do |section|
	KepplerCatalogs::Catalog.create name: section, description: "", section: section,  public: true
	puts "Catalogo #{section} ha sido creado"
end
["Audios", "Imagenes", "Videos"].each do |category|
	KepplerCatalogs::Category.create name: category
	puts "Categoria #{category} ha sido creado"
end
