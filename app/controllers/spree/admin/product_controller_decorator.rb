# Modified by Ray Gao to temporary add:
#   1. Save 'product' and 'variant' to Heroku Connect DB, when a new 'product' is created.
#   2. removed for AliConnect

Spree::Admin::ProductsController.class_eval do

  # update the HC DB as well   # removed Heroku Connect
  def update
    if params[:product][:taxon_ids].present?
      params[:product][:taxon_ids] = params[:product][:taxon_ids].split(',')
    end
    if params[:product][:option_type_ids].present?
      params[:product][:option_type_ids] = params[:product][:option_type_ids].split(',')
    end
    invoke_callbacks(:update, :before)
    if @object.update_attributes(permitted_resource_params)
      invoke_callbacks(:update, :after)
      flash[:success] = flash_message_for(@object, :successfully_updated)

      respond_with(@object) do |format|
        format.html { redirect_to location_after_save }
        format.js   { render :layout => false }
      end
    else
      # Stops people submitting blank slugs, causing errors when they try to update the product again
      @product.slug = @product.slug_was if @product.slug.blank?
      invoke_callbacks(:update, :fails)
      respond_with(@object)
    end
  end


  # Spree never deletes anything, it just set to silent with a 'deleted_at' timestamp flag

  # Save 'product' and 'variant' to Heroku Connect DB, when a new 'product' is created.
  def create
    invoke_callbacks(:create, :before)
    @object.attributes = permitted_resource_params
    if @object.save
      invoke_callbacks(:create, :after)

      flash[:success] = flash_message_for(@object, :successfully_created)
      respond_with(@object) do |format|
        format.html { redirect_to location_after_save }
        format.js   { render :layout => false }
      end
    else
      invoke_callbacks(:create, :fails)
      respond_with(@object)
    end
  end

end