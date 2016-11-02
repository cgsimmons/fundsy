require 'rails_helper'

RSpec.describe Pledge, type: :model do
  describe 'validations' do
    it 'requires an amount greater than' do
      p = Pledge.new amount: 0
      p.valid?
      expect(p.errors).to have_key :amount
    end
  end
end
