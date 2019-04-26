class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.items.all
  end

  def show
    @item = find_user_item
  end

  def new
    @item = current_user.items.new
  end

  def create
    @item = current_user.items.new(item_params)
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

  def find_user_item
    current_user.items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to items_path, alert: 'Item does not exist' }
    end
  end
end
