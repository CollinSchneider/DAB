class Api::InventoriesController < ApplicationController

  def index
    dbInventories = Inventory.all
    render json: {inventories: dbInventories}
  end

  def create
    new_inventory = Inventory.create( inventory_params )
    render json: new_inventory
  end

  private
  def inventory_params
    params.require(:inventory).permit(:product_id, :quantity, :size)
  end

end
