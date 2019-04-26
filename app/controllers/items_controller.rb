class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Your item has been submitted successfully!'
    else
      render :new, alert: 'Alert!'
    end
  end

  private

  def item_params
    params.require(:item).permit(:isbn, :title, :value)
  end
end
