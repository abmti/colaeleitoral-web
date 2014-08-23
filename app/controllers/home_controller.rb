class HomeController < ApplicationController
  
  include HomeHelper

  def index
  end
  
  def cola
    device_id = params[:device_id]
    
    if device_id != nil && Cola.where(device_id: device_id).length > 0
      @cola = Cola.where(device_id: device_id).first
      @cola.cola_cargo.each do |cola_cargo|
        cola_cargo.detalhes_candidatos = Array.new
        cola_cargo.candidatos.each do |cand|
          cola_cargo.detalhes_candidatos << detalhes_candidato(cand)
        end
      end
    else
      cargos = lista_cargos(params[:uf])
      @cola = Cola.new
      @cola.device_id = device_id
      @cola.uf = params[:uf]
      @cola.save
      cargos.each do |c|
        cc = @cola.cola_cargo.build({id_cargo: c["cargoId"], nome_cargo: c["nome"], candidatos: Array.new})
        cc.save
      end
    end
    
    respond_to do |format|
      format.html { 
        redirect_to edit_path(@cola.id)
      }
      format.json { render :json => @cola.as_json_cola }
    end
  end
  
  def detalhe_candidato
    @candidato = detalhes_candidato(params[:candidato_id])
  end
  
  def remove
    cola = Cola.find(params[:cola_id])
    cola_cargo = cola.cola_cargo.where(id: params[:cola_cargo_id]).first
    cola_cargo.candidatos.delete(params[:candidato_id])
    cola_cargo.save
    respond_to do |format|
      format.html { redirect_to edit_path(cola.id) }
      format.json { render :json => {status: "ok"} }
    end
  end
  
  def view
    @cola = Cola.find(params[:id])
    @cola.cola_cargo.each do |cola_cargo|
      cola_cargo.detalhes_candidatos = Array.new
      cola_cargo.candidatos.each do |cand|
        cola_cargo.detalhes_candidatos << detalhes_candidato(cand)
      end
    end
  end
  
  def estados
    respond_to do |format|
        format.json { render :json => lista_estados }
    end
  end
  
  def avalia
    avaliacao = params[:avaliacao]
    cola = Cola.find(params[:cola_id])
    if avaliacao == 'y'
      cola.cola_cargo.each do |cargo|
        if cargo.id_cargo == params[:cargo_id]
          if !cargo.candidatos.include?(params[:candidato_id])
            cargo.candidatos << params[:candidato_id]
            cargo.save
          end
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to roleta_path(cola.id, params[:cargo_id], params[:partido]) }
      format.json { render :json => {status: "ok"} }
    end
  end
  
  def candidatos
    respond_to do |format|
      rand = rand(0 .. (Total.consulta(params[:uf], params[:cargo_id]).quantidade / 10) )
      format.json { render :json => lista_candidatos(params[:cargo_id], params[:uf], rand) }
    end
  end
  
  def roleta
    @cargo_id = params[:cargo]
    @cola = Cola.find(params[:cola_id])
    @partido = params[:partido]
    rand = rand(0 .. (Total.consulta(@cola.uf, params[:cargo]).quantidade / 10) )
    candidatos = random_candidato(params[:cargo], @cola.uf, @partido, rand)
    @candidato = candidatos[rand(0 .. candidatos.length-1 )]
    puts @candidato
  end
  
  def edit
    @cola = Cola.find(params[:id])
    @cola.cola_cargo.each do |cola_cargo|
      cola_cargo.detalhes_candidatos = Array.new
      cola_cargo.candidatos.each do |cand|
        cola_cargo.detalhes_candidatos << detalhes_candidato(cand)
      end
    end
  end
  
end
