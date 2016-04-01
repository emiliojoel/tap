json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :amount, :limit, :20, :desc, :date, :status, :limit
  json.url invoice_url(invoice, format: :json)
end
