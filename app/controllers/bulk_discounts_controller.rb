class BulkDiscountsController < ApplicationController
  before_action :set_merchant, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
  def index
    @bulk_discounts = BulkDiscount.all
  end

  def show 
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
   @bulk_discount = @merchant.bulk_discounts.build
  end

  def create
    if params[:bulk_discount][:percentage_discount].to_i > 100
      flash.notice = "Discount cannot be greater than 100%"
      redirect_to new_merchant_bulk_discount_path(@merchant)
    else
      @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    if @bulk_discount.save
      render :index
    else
      render :new
    end
  end
end

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @bulk_discount = BulkDiscount.find(params[:id])
  
    if params[:bulk_discount][:percentage_discount].to_i > 100
      flash.notice = "Discount cannot be greater than 100%"
      redirect_to edit_merchant_bulk_discount_path(@merchant.id, @bulk_discount.id)
    else 
      @bulk_discount.update(bulk_discount_params)
      redirect_to merchant_bulk_discount_path(@merchant.id, @bulk_discount.id)
    end
  end

  def destroy  
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage_discount, :quantity_threshold, :merchant_id)
  end
end