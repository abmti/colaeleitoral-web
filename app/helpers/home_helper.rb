
require 'httparty'

module HomeHelper
  
  def lista_estados
    estados = HTTParty.get("http://api.transparencia.org.br/sandbox/v1/estados", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
    estados_sem_br = Array.new
    estados.each do |e|
      if e["estadoId"] != "0"
        estados_sem_br << e
      end
    end
    estados_sem_br
  end
  
  def lista_cargos(uf)
    retorno = Array.new
    cargos = HTTParty.get("http://api.transparencia.org.br/sandbox/v1/cargos", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
    cargos.each do |c|
      if c["cargoId"] == "1" || c["cargoId"] == "3" || c["cargoId"] == "5" || c["cargoId"] == "6"
        retorno << c
      end
      if c["cargoId"] == "8" && uf == "DF"
        retorno << c
      elsif c["cargoId"] == "7" && uf != "DF"
        retorno << c
      end  
    end
    retorno
  end
  
end

