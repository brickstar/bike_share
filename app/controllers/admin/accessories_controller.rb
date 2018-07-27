class Admin::AccessoriesController < ApplicationController
  before_action :set_accessory, only: [:edit, :update]

  def index
    @accessories = Accessory.all
  end

  def edit

  end

  def update
    @accessory.update(admin_accessory_params)
    if @accessory.save
      flash[:success] = "Accessory #{@accessory.title} updated."
      redirect_to admin_accessories_path
    else
      render :edit
    end
  end

  private

  def admin_accessory_params
    params.require(:accessory).permit(:title, :description, :status, :price)
  end

  def set_accessory
    @accessory = Accessory.find(params[:id])
  end
end
