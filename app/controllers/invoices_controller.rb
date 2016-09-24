class InvoicesController < ApplicationController
 # before_action :authenticate_user!
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :payment]
  before_action :set_signature, only: [:payment]
  before_action :set_header
  before_action :admin_user!, only: [:new, :edit, :update, :destroy, :create]

  # GET /invoices
  # GET /invoices.json
  def index
  if current_user.admin?
       @invoices = Invoice.all
        else
    @invoices = current_user.invoices.all
    end 
  @login = current_user.email
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    
       @label = "Nueva"
       @button = "Crear Orden"
       @invoice = Invoice.new
       
  end

  # GET /invoices/1/edit
  def edit
    @label = "Editar"
    @button = "Modificar Orden"
     
  end

  # POST /invoices
  # POST /invoices.json
  def create
    
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PAYMENT OK /invoices/OK
  def OK
      respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'La orden correctamente aceptada para pago a plazos.' }
      format.json { head :no_content }
    end
  end
 
# PAYMENT KO /invoices/KO
  def KO
      respond_to do |format|
      format.html { redirect_to invoices_url, alert: 'La orden no fue acceptada para pago a plazos.' }
      format.json { head :no_content }
    end
  end

  # PAYMENT
  def payment
      #redirect_to generate_url("https://pmt.pagantis.com/v1/installments", :param1 => @invoice.id, :param2 => @invoice.amount)
      #redirect_to pmt_site_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def set_signature
      @account_id = "tk_f36092c67ea4cbc8e954aa2c"
      ck = "04d8871b2bbeb279"
      @ok_url = "https://url/invoice/OK"
      @nok_url = "https://url/invoice/KO"
      amount = @invoice.amount
      @currency = "EUR"
      order_id = @invoice.id.to_s
      @callback_url = "http://mi_tienda/pmt/validation"
      signature_fields = ck + @account_id + order_id + amount + @currency + @ok_url + @nok_url + @callback_url
      @sign=Digest::SHA1.hexdigest(signature_fields)
    end
    


  def set_header
      @header = "Ordenes"
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:amount, :desc, :date, :status, :user_id)
    end

  def generate_url(url, params = {})
      uri = URI(url)
      uri.query = params.to_query
      uri.to_s
     end  
end
