require 'csv'

task :import => :environment do

  models = [Customer, Merchant, Item, Invoice, InvoiceItem, Transaction]
  models.each {|model| model.destroy_all}

  puts "Importing Customers"

  customers = CSV.read("./db/data/customers.csv", headers: true, header_converters: :symbol)
  customers.each do |customer| 
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    Customer.create!(customer.to_h)
  end

  puts "Importing Merchants"

  merchants = CSV.read("./db/data/merchants.csv", headers: true, header_converters: :symbol)
  merchants.each do |merchant| 
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    Merchant.create!(merchant.to_h)
  end

  ActiveRecord::Base.connection.execute('ALTER SEQUENCE merchants_id_seq RESTART WITH 101')

  puts "Importing Items"

  items = CSV.read("./db/data/items.csv", headers: true, header_converters: :symbol)
  items.each do |item|
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    new_item = Item.new(item.to_h)
    new_item.unit_price = (new_item.unit_price / 100.to_f)
    new_item.save
  end

  ActiveRecord::Base.connection.execute('ALTER SEQUENCE items_id_seq RESTART WITH 2484')

  puts "Importing Invoices"

  invoices = CSV.read("./db/data/invoices.csv", headers: true, header_converters: :symbol)
  invoices.each do |invoice| 
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    Invoice.create!(invoice.to_h)
  end

  puts "Importing Invoice Items"

  invoice_items = CSV.read("./db/data/invoice_items.csv", headers: true, header_converters: :symbol)
  invoice_items.each do |invoiceitem| 
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    InvoiceItem.create!(invoiceitem.to_h)
  end

  puts "Importing Transactions"

  transactions = CSV.read("./db/data/transactions.csv", headers: true, header_converters: :symbol)
  transactions.each do |transaction| 
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    Transaction.create!(transaction.to_h)
  end
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