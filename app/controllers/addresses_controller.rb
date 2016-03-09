class AddressesController < ApplicationController

  def create
    authenticate_user
    Address.create(address_params)
    redirect_to request.referrer
  end

  def destroy
    authenticate_user
    address = Address.find(params[:id])
    address.delete
    redirect_to request.referrer
  end

  private
  def address_params
    params.require(:address).permit(:user_id, :name, :country, :state, :zip, :city, :address, :active)
  end

end
