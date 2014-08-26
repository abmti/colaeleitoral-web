
require 'httparty'

module HomeHelper
  
  def lista_estados
    Estado.all
  end
  
  def lista_partidos
    partidos = HTTParty.get("http://api.transparencia.org.br/api/v1/partidos", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
    partidos
  end
  
  def detalhes_candidato(candidato_id)
    candidato = HTTParty.get("http://api.transparencia.org.br/api/v1/candidatos/#{candidato_id}", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
    candidato
  end
  
  def lista_candidatos(cargo_id, uf, partido, page)
    if partido.strip.length > 0 && partido != "n"
      candidatos = HTTParty.get("http://api.transparencia.org.br/api/v1/candidatos?estado=#{uf}&partido=#{partido}&cargo=#{cargo_id}&_limit=10&_offset=#{page}", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
    else
      candidatos = HTTParty.get("http://api.transparencia.org.br/api/v1/candidatos?estado=#{uf}&cargo=#{cargo_id}&_limit=10&_offset=#{page}", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
    end
    candidatos
  end
  
  def random_candidato(cargo_id, uf, partido, page)
    if partido.strip.length > 0 && partido != "n"
      candidatos = HTTParty.get("http://api.transparencia.org.br/api/v1/candidatos?estado=#{uf}&partido=#{partido}&cargo=#{cargo_id}&_limit=10&_offset=#{page}", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
    else
      candidatos = HTTParty.get("http://api.transparencia.org.br/api/v1/candidatos?estado=#{uf}&cargo=#{cargo_id}&_limit=10&_offset=#{page}", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
    end
    candidatos
  end
  
  def lista_cargos(uf)
    retorno = Array.new
    cargos = HTTParty.get("http://api.transparencia.org.br/api/v1/cargos", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
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
  
  def link_edit(id)
    "#{request.protocol}#{request.host_with_port}/edit/#{id}"
  end
  
  def link_view(id)
    "#{request.protocol}#{request.host_with_port}/v/#{id}"
  end
  
  def cor_cargo(tamanho)
    if tamanho == 0
      return "ffffff"
    elsif tamanho == 1
      return "33FF99"
    else
      return "FFFF99"
    end
  end
  
end

