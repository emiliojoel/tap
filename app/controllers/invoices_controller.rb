class InvoicesController < ApplicationController
 # before_action :authenticate_user!
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

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
    if current_user.admin?
       @label = "Nueva"
       @button = "Crear Orden"
       @invoice = Invoice.new
        else
    redirect_to :action => 'index'
    end
  end

  # GET /invoices/1/edit
  def edit
    if current_user.admin?
    @label = "Editar"
    @button = "Modificar Orden"
    else
    redirect_to :action => 'index'
    end
  end

  # POST /invoices
  # POST /invoices.json
  def create
    if !(current_user.admin?)
        redirect_to :action => 'index'
    end
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
    if !(current_user.admin?)
        redirect_to :action => 'index'
    end
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
    if !(current_user.admin?)
        redirect_to :action => 'index'
    end
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      if !(current_user.admin?)
        redirect_to :action => 'index'
    end
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:amount, :desc, :date, :status, :user_id)
    end
end
