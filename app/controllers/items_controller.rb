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
        format.html { redirect_to @item, notice: t('.success_flash') }
      end
    else
      flash.now[:alert] = t('.errors_flash')
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: t('.success_flash')
    else
      flash.now[:alert] = t('.errors_flash')
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @item.destroy
      respond_to do |format|
        format.html { redirect_to items_path, notice: t('.success_flash') }
      end
    else
      respond_to do |format|
        format.html { redirect_to items_path, alert: t('.errors_flash') }
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
      format.html { redirect_to items_path, alert: t('items.shared.does_not_exist') }
    end
  end
end