require 'csv'

task :import => :environment do
  customers = CSV.read(“./db/data/customers.csv”, headers: true, header_converters: :symbol)
  customers.each {|customer| Customer.create!(customer.to_h)}

  merchants = CSV.read(“./db/data/merchants.csv”, headers: true, header_converters: :symbol)
  merchants.each {|merchant| Merchant.create!(merchant.to_h)}

  items = CSV.read(“./db/data/items.csv”, headers: true, header_converters: :symbol)
  items.each {|item| Item.create!(item.to_h)}

  invoices = CSV.read(“./db/data/invoices.csv”, headers: true, header_converters: :symbol)
  invoices.each {|invoice| Invoice.create!(invoice.to_h)}

  invoice_items = CSV.read(“./db/data/invoice_items.csv”, headers: true, header_converters: :symbol)
  invoice_items.each {|invoiceitem| InvoiceItem.create!(invoiceitem.to_h)}

  transactions = CSV.read(“./db/data/transactions.csv”, headers: true, header_converters: :symbol)
  transactions.each {|transaction| Transaction.create!(transaction.to_h)}

end