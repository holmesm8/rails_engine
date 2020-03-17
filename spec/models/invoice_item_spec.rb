require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do 

  describe 'validations' do 
    it { should validate_presence_of :quantity}
    it { should validate_presence_of :unit_price} 
  end 

  # describe 'relationships' do 
  #   it { should have_many }
  #   it { should have_many().through() }
  # end 

  # describe 'methods' do
  # end

end