require 'rails_helper'
require 'faker'

RSpec.describe Campaign, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # write validations test.  can also use 'context' but
  # here describe makes more sense for readability

  describe 'validations' do
    # test example 'it' or 'specify'
    # put a message for every example, expecially to explain
    it 'requires a title' do
      #GIVEN
      c = Campaign.new
      #wWHEN
      c.valid?
      #THEN
      #Resulting object is invalid
      # expect(c).to be_invalid
      # more specific
      expect(c.errors).to have_key(:title)
    end

    # test that new entry has a unique title
    it 'requires a unique title' do
      #GIVEN
      # Campaign.create({title: 'Some valid title', goal:10})
      FactoryGirl.create :campaign, title: 'Some valid title'
      c = Campaign.new title: 'Some valid title'

      #WHEN
      c.valid?

      #THEN
      expect(c.errors).to have_key(:title)
    end

    it 'requires a goal of $10 or more' do
      c = Campaign.new goal: 9
      c.valid?

      expect(c.errors).to have_key(:goal)
    end
  end

  describe '.titleized_title' do
    it 'returns a titleized version of the title' do
      c = Campaign.new title: 'hello world'
      result = c.titleized_title
      expect(result).to eq('Hello World')
    end
  end
end
