class PromotionsController < ApplicationController
    before_action :authenticate_user!, only: %i[index]
    before_action :set_promotion, only: %i[show edit update destroy generate_coupons]

    def index
        @promotions = Promotion.all
    end

    def show; end

    def new
        @promotion = Promotion.new
    end

    def create
        @promotion = Promotion.new(promotion_params)
        
        if @promotion.save
          redirect_to @promotion
        else
            render :new
        end
    end

    def edit; end  

    def update
        if @promotion.update(promotion_params)
            redirect_to root_path
        else
            render :edit
        end
      end
    
      def destroy
        @promotion.destroy
        redirect_to root_path
      end    

    def generate_coupons
        @promotion.generate_coupons!
        flash[:notice] = 'Cupons gerados com sucesso'
        redirect_to @promotion
    end

    private

    def promotion_params
        params.require(:promotion)
              .permit(:name,
                      :description,
                      :code,
                      :discount_rate,
                      :coupon_quantity,
                      :expiration_date)
    end

    def set_promotion
        @promotion = Promotion.find(params[:id])
    end

end