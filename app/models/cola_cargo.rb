class ColaCargo

  include Mongoid::Document
  
  embedded_in :cola
  
  field :id_cargo, type: String
  field :nome_cargo, type: String
  field :candidatos, type: Array
  
  attr_accessor :detalhes_candidatos
  
  
end