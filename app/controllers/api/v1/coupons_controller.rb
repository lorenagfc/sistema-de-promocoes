module Api
  module V1
    class CouponsController < ApiController
      before_action :verify_coupon_code, only: %i[burn]

      def show
        # achar o cupom
        #@coupon = Coupon.find_by(code: params[:code])
        # transformar o cupom em json
        #@json = @coupon.to_json
        # mandar o cupom pelo render json
        #render json: @json, status :ok #sem view

        #@coupon = Coupon.find_by(code: params[:code])
        #json = { discount: @coupon.promotion.discount_rate,
                 #expiration_date: I18n.l(@coupon.promotion.expiration_date) }
        #render json: @json, status :ok

        @coupon = Coupon.find_by(code: params[:code])
        return render json: 'Cupom não encontrado', status: :not_found if @coupon.nil?
        render json: @coupon, status: :ok #as_json pode ser removido pois é padrao
      
        #ao invés do return,
        #rescue ActiveRecord::RecordNotFound
          #render json: 'Cupom não encontrado', status: :not_found
        #end
      end

      def burn
        @coupon = Coupon.find_by!(code: params[:code])
        @coupon.burn!(params[:order][:code])
        #@coupon.burn!(params.require(:order).permit(:code)[:code])
        #@coupon.order = params[:order][:code]
        #@coupon.burn!
        render json: 'Cupom utilizado com sucesso', status: :ok
      
        rescue ActionController::ParameterMissing
          render json '', status: :precondition_failed
        
        rescue ActionController::ParameterMissing
          render json '', status: 422
      end

      private

      def verify_coupon_code
        return if params.dig(:order, :code)
        render json: '', status: :precondition_failed
      end

    end
  end
end