class Total
  
  include Mongoid::Document
  
  field :uf, type: String
  field :cargo, type: String
  field :quantidade, type: Integer
  
  def self.consulta(uf, cargo)
    total = Total.where({"uf" => uf, "cargo" => cargo}).first
    if total == nil
      total = Total.new
      total.quantidade = checa_quantidade(uf, cargo)
      total.uf = uf
      total.cargo = cargo
      total.save
    end
    total
  end
  
  private
  
  def self.checa_quantidade(uf, cargo)
    soma_recursivo(uf, cargo, 0)
  end
  
  def self.soma_recursivo(uf, cargo, pagina)
    puts "pagina = #{pagina}"
    candidatos = HTTParty.get("http://api.transparencia.org.br/api/v1/candidatos?estado=#{uf}&cargo=#{cargo}&_limit=20&_offset=#{pagina}", :headers => { "App-Token" => ENV['TRANSPARENCIA_TOKEN'] } )
    if candidatos.length < 20
      puts "fim da lista... retornando #{candidatos.length}"
      return candidatos.length
    else
      soma = soma_recursivo(uf, cargo, pagina+1)
      puts "continua somando... #{candidatos.length+soma}"
      return (candidatos.length + soma)
    end
  end
  
end