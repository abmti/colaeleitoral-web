class Cola

  include Mongoid::Document
  
  embeds_many :cola_cargo, class_name: "ColaCargo"
  
  field :id_view, type: String
  field :device_id, type: String
  field :uf, type: String
  
end