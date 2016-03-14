class AddressesController < ApplicationController

  def create
    authenticate_user
    address = Address.create(address_params)
    current_user.addresses.each do |add|
      add.active = 'no'
      add.save
    end
    address.active = 'yes'
    address.save
    redirect_to request.referrer
  end

  def destroy
    authenticate_user
    address = Address.find(params[:id])
    address.delete
    redirect_to request.referrer
  end

  def update
    authenticate_user
    all_addresses = Address.all
    all_addresses.each do |address|
      address.active = 'no'
      address.save
    end
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to request.referrer
  end

  private
  def address_params
    params.require(:address).permit(:user_id, :name, :country, :state, :zip, :city, :address, :active)
  end

end
