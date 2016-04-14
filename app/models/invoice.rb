class Invoice < ActiveRecord::Base
	belongs_to :user

STATUS = ["Pendiente", "Pagada", "Denegada"]

	def self.user_for_select
    User.all.collect{|p| [p.email, p.id]}
    end
 
def self.status_for_select
    STATUS.collect{|e| [e,e]}
  end

end
