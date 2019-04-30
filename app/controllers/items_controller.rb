require 'services/isbn_service'

class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_item, only: [:show, :edit, :lookup_edit, :update, :destroy]

  def index
    @items = current_user.items.where(nil)
    @items = @items.author(params[:author]) if params[:author]
    @items = @items.category(params[:category]) if params[:category]
    @items = @items.clike(params[:clike]) if params[:clike]
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

  def lookup_new
    @item = current_user.items.new
    isbn = params[:item][:isbn]
    book = Services::ISBNService.new(isbn)
    book.lookup
    @item.title = book.title
    @item.isbn = book.isbn
    @item.authors = book.authors
    @item.categories = book.categories
    @item.description = book.description
    @item.publisher = book.publisher
    render :new
  end

  def lookup_edit
    isbn = params[:item][:isbn]
    book = Services::ISBNService.new(isbn)
    book.lookup
    @item.title = book.title
    @item.isbn = book.isbn
    @item.authors = book.authors
    @item.categories = book.categories
    @item.description = book.description
    @item.publisher = book.publisher
    render :edit
  end

  private

  def item_params
    params.require(:item).permit(:isbn, :title, :authors, :categories,
      :description, :publisher, :published_on, :page_count, :value)
  end

  def find_user_item
    @item = current_user.items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to items_path, alert: t('items.shared.does_not_exist') }
    end
  end
end
