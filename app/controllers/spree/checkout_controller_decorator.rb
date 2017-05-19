# Modified by Ray Gao to temporary add:
#   1. GeoSpatial capability
#   2. Save to Heroku Connect DB
#   3. removed Heroku Connect DB for AliConnect

Spree::CheckoutController.class_eval do

  # Modified to save 'geo-spatial'  #Ray
  def update
    if @order.update_from_params(params, permitted_checkout_attributes)
      # There is a defect here. It's not taking the address from the param.
      # Modified by Ray Gao to temporary add GeoSpatial capability, 'persist_user_address' is defective, it never saves new address.
      if (params[:order][:bill_address_attributes] != nil)
        Spree::Address.find(@order[:bill_address_id]).update_attribute("geo_lat", params[:order][:bill_address_attributes][:geo_lat])
        Spree::Address.find(@order[:bill_address_id]).update_attribute("geo_long", params[:order][:bill_address_attributes][:geo_long])
        Spree::Address.find(@order[:bill_address_id]).save

        logger.info '===== updated bill address ==='

        Spree::Address.find(@order[:ship_address_id]).update_attribute("geo_lat", params[:order][:bill_address_attributes][:geo_lat])
        Spree::Address.find(@order[:ship_address_id]).update_attribute("geo_long", params[:order][:bill_address_attributes][:geo_long])
        Spree::Address.find(@order[:ship_address_id]).save
        logger.info '===== updated ship address ==='
      end
      # Fixed by ray, temporary for demo

      persist_user_address
      unless @order.next
        flash[:error] = @order.errors.full_messages.join("\n")
        redirect_to checkout_state_path(@order.state) and return
      end

      if @order.completed?
        session[:order_id] = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash[:commerce_tracking] = "nothing special"
        redirect_to completion_route
      else
        redirect_to checkout_state_path(@order.state)
      end
    else
      render :edit
    end
  end

end