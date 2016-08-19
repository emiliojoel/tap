class InvoicesController < ApplicationController
 # before_action :authenticate_user!
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

def set_header
      @header = "Ordenes"
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:amount, :desc, :date, :status, :user_id)
    end
end
