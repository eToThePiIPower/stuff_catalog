class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = current_user.items.all
  end

  def show; end

  def new
    @item = current_user.items.new
  end

  def edit; end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      respond_to do |format|
        format.html { redirect_to @item, notice: 'Your item has been submitted successfully!' }
      end
    else
      flash.now[:alert] = 'There were errors in the item.'
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Your item has been updated successfully!'
    else
      flash.now[:alert] = 'There were errors in the item.'
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @item.destroy
      respond_to do |format|
        format.html { redirect_to items_path, notice: 'Your item has been deleted.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to items_path, alert: 'Item could not be deleted!' }
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:isbn, :title, :value)
  end

  def find_user_item
    @item = current_user.items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to items_path, alert: 'Item does not exist' }
    end
  end
end
