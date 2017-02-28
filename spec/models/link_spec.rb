require 'rails_helper'

describe Link do
  describe '.create_ensuring_uniqueness' do
    describe 'creates link' do
      before(:each) do
        @link = Link.create_ensuring_uniqueness('http://google.com')
      end

      it 'fill in original_url' do
        expect(@link.original_url).to eq 'http://google.com'
      end

      it 'fill in short_url' do
        expect(@link.original_url).to be_present
      end
    end

    it 'returns existing original link' do
      existing_link = Link.create_ensuring_uniqueness('http://google.com')
      expect(Link.create_ensuring_uniqueness('http://google.com')).to eq(existing_link)
    end

    it 'doest not duplicte short_url' do
      link = Link.create_ensuring_uniqueness('http://google.com')
      l = Link.new(original_url: 'http://yahoo.com', short_url: link.short_url)
      expect{ l.save }.to raise_error
    end
  end

  describe '#generate_short_url' do
    it 'filling in short_url' do
      link = Link.new
      link.generate_short_url(6)
      expect(link.short_url.length).to eq(6)
    end
  end
end
