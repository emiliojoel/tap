class OperationsController < ApplicationController
  before_action :set_operation, only: [:show]
  before_action :protect_CB, only: [:CB]
  skip_before_action :verify_authenticity_token, only: [:CB]
  skip_before_action :authenticate_user!, only: [:CB]
  before_action :admin_user!

  # GET /operations
  # GET /operations.json
  def index
    @operations = Operation.all
  end

  # GET /operations/1
  # GET /operations/1.json
  def show
  end

  # GET /operations/new
 # def new
 #   @operation = Operation.new
 # end

  # GET /operations/1/edit
  #def edit
  #end

  # POST /operations
  # POST /operations.json
  #def create
  #  @operation = Operation.new(operation_params)

  #  respond_to do |format|
  #    if @operation.save
  #      format.html { redirect_to @operation, notice: 'Operation was successfully created.' }
  #      format.json { render :show, status: :created, location: @operation }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @operation.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /operations/1
  # PATCH/PUT /operations/1.json
  #def update
  #  respond_to do |format|
  #    if @operation.update(operation_params)
  #      format.html { redirect_to @operation, notice: 'Operation was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @operation }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @operation.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /operations/1
  # DELETE /operations/1.json
  #def destroy
  #  @operation.destroy
  #  respond_to do |format|
  #    format.html { redirect_to operations_url, notice: 'Operation was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  # POST callback /operations/CB
  def CB

      invoice_updater
      @operation = Operation.new(operation_params)
  #    respond_to do |format|
      if @operation.save
  #       format.json { render :show, status: :created, location: @operation }
          render :text => "Notification successful"  
      else
  #      format.json { render json: @operation.errors, status: :unprocessable_entity }
         render :text => "Notification not saved"  
      end
  #  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_params
      #params.require(:operation).permit(:event, :api_version, :account_id, :signature, data: [])
      params.require(:operation).permit!
    end
    def protect_CB
        @ips = ['54.194.87.61', '54.171.124.55', '172.17.0.1'] 
            if not @ips.include? request.remote_ip
             # Check for your subnet stuff here, for example
             # if not request.remote_ip.include?('127.0,0')
             render :text => "#{request.remote_ip} You are unauthorized"
             return
            end
     end

    def invoice_updater
        invoice = Invoice.find_by(id: operation_params[:data][:order_id])
        if operation_params[:event] == "charge.created" && invoice.present? then
            invoice.update(status: 'Pagada')
        elsif operation_params[:event] == "charge.failed" && invoice.present? then
             invoice.update(status: 'Denegada')            
         end
     end
end
