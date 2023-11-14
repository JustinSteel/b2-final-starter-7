class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = BulkDiscount.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
   @merchant = Merchant.find(params[:merchant_id])
   @bulk_discount = @merchant.bulk_discounts.build
  end

  def create
    @bulk_discount = BulkDiscount.create!(bulk_discount_params)
    redirect_to merchant_bulk_discounts_path(@bulk_discount.merchant_id)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    if params[:percentage_discount].to_i > 100
      flash.notice = "Discount cannot be greater than 100%"
    else 
      @merchant = Merchant.find(params[:merchant_id])
      @bulk_discount = BulkDiscount.find(params[:id])
      @bulk_discount.update(bulk_discount_params)
      redirect_to merchant_bulk_discount_path(@merchant.id, @bulk_discount.id)
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])  
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage_discount, :quantity_threshold, :merchant_id)
  end
end