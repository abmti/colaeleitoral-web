class Cola

  include Mongoid::Document
  
  embeds_many :cola_cargo, class_name: "ColaCargo"
  
  field :id_view, type: String
  field :device_id, type: String
  field :uf, type: String
  
  def as_json_cola
    retorno = self.as_json
    retorno[:cola_cargo] = Array.new
    cola_cargo.each do |cola|
      cc = cola.as_json
      cc[:candidatos] = Array.new
      if cola.detalhes_candidatos
        cola.detalhes_candidatos.each do |cand|
          cc[:candidatos] << cand
        end
      end
      retorno[:cola_cargo] << cc
    end
    retorno
  end
  
end