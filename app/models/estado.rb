class Estado
  
  include Mongoid::Document
  
  field :sigla, type: String
  field :bandeira, type: String
  field :estadoId, type: String
  field :nome, type: String
  
end