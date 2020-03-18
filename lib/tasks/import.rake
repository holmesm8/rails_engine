require 'csv'

task :import => :environment do
  customers = CSV.read("./db/data/customers.csv", headers: true, header_converters: :symbol)
  customers.each {|customer| Customer.create!(customer.to_h)}

  merchants = CSV.read("./db/data/merchants.csv", headers: true, header_converters: :symbol)
  merchants.each {|merchant| Merchant.create!(merchant.to_h)}

  items = CSV.read("./db/data/items.csv", headers: true, header_converters: :symbol)
  items.each {|item| Item.create!(item.to_h)}

  invoices = CSV.read("./db/data/invoices.csv", headers: true, header_converters: :symbol)
  invoices.each {|invoice| Invoice.create!(invoice.to_h)}

  invoice_items = CSV.read("./db/data/invoice_items.csv", headers: true, header_converters: :symbol)
  invoice_items.each {|invoiceitem| InvoiceItem.create!(invoiceitem.to_h)}

  transactions = CSV.read("./db/data/transactions.csv", headers: true, header_converters: :symbol)
  transactions.each {|transaction| Transaction.create!(transaction.to_h)}

end

# Refactored to rake all. Comment out the above and uncomment below to run rake import on a specific table only

# namespace :import do
#   task :customers => :environment do
#     customers = CSV.read("./db/data/customers.csv", headers: true, header_converters: :symbol)
#     customers.each {|customer| Customer.create!(customer.to_h)}
#   end

#   task :merchants => :environment do
#     merchants = CSV.read("./db/data/merchants.csv", headers: true, header_converters: :symbol)
#     merchants.each {|merchant| Merchant.create!(merchant.to_h)}
#   end
  
#   task :items => :environment do
#     items = CSV.read("./db/data/items.csv", headers: true, header_converters: :symbol)
#     items.each {|item| Item.create!(item.to_h)}
#   end
  
#   task :invoices => :environment do
#     invoices = CSV.read("./db/data/invoices.csv", headers: true, header_converters: :symbol)
#     invoices.each {|invoice| Invoice.create!(invoice.to_h)}
#   end
  
#   task :invoice_items => :environment do
#     invoice_items = CSV.read("./db/data/invoice_items.csv", headers: true, header_converters: :symbol)
#     invoice_items.each {|invoiceitem| InvoiceItem.create!(invoiceitem.to_h)}
#   end

#   task :transactions => :environment do
#     transactions = CSV.read("./db/data/transactions.csv", headers: true, header_converters: :symbol)
#     transactions.each {|transaction| Transaction.create!(transaction.to_h)}
#   end
# end 