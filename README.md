### KEPPLER CMS

KEPPLER CMS es una plataforma de aplicaciones de código abierto de vanguardia basado en la plataforma Ruby on Rails.

La plataforma cuenta con una base de gemas ya integradas, de tal forma que acelerará el desarrollo de aplicaciones.

### Características

* Integración para autenticación de usuarios con [Devise](https://github.com/plataformatec/devise)
* Integración para roles de usuarios con [Rolify](https://github.com/RolifyCommunity/rolify)
* Integración para autorizaciones con [CanCanCan](https://github.com/CanCanCommunity/cancancan)
* Integración para helpers de formularios con [SimpleForm](https://github.com/RolifyCommunity/rolify)
* Integración para búsquedas full-text con [ElasticSearch](https://github.com/elastic/elasticsearch-rails)
* Integración con framework fronte-end para el administrativo con [Materialize](http://materializecss.com/)

# inputs examples

file: = f.input :image, :as => :file_material, label: false, wrapper_html: { class: "file-field" }
select: = f.input :role_ids, collection: Role.all, label: false, include_blank: "Selecione un rol"
radio_buttons: = f.collection_radio_buttons :option, [['vegan', 'vegan'] ,['vegetarian', 'vegetarian']],:first, :last
checkbox: = f.collection_check_boxes :options, [['vegan', 'vegan'] ,['vegetarian', 'vegetarian']],:first, :last
date: = f.input :date, input_html: {class: "datepicker"}

# Keppler Scaffold

rails g keppler_scaffold <module_name> <attributes>
