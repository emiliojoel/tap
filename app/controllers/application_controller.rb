class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  




  layout 'admin_lte_2'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :admin_user!



protected

 def admin_user!

if !(current_user.admin?)
       redirect_to invoices_path
    end
end

end
