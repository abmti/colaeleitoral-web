class HomeController < ApplicationController
  
  include HomeHelper

  def index
  end
  
  def cola
    device_id = params[:device_id]
    
    if device_id != nil && Colada.where(device_id: device_id).length > 0
      @cola = Colada.where(device_id: device_id).first
      @cola.cola_cargo.each do |cola_cargo|
        cola_cargo.detalhes_candidatos = Array.new
        cola_cargo.candidatos.each do |cand|
          cola_cargo.detalhes_candidatos << detalhes_candidato(cand)
        end
      end
    else
      cargos = lista_cargos(params[:uf])
      @cola = Colada.new
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
  
end
