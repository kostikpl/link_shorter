require 'rails_helper'

describe LinksController do
  describe 'GET #show' do
    it 'redirects to original_url' do
      link = Link.create_ensuring_uniqueness('http://google.com')
      get :show, short_url: link.short_url
      expect(response).to redirect_to link.original_url
    end

    it 'redirects to root_path if link not found' do
      get :show, short_url: 'wrongshorturl'
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET #new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe 'POST #create' do
    let(:valid_request) { post :create, link: { original_url: 'http://google.com' } }
    let(:invalid_request) { post :create, link: { original_url: 'google.com' } }

    it 'renders show template' do
      valid_request
      expect(response).to render_template 'show'
    end

    it 'creates new link with valid params' do
      expect{ valid_request }.to change(Link, :count).by(1)
    end

    it 'does not creates new link with invalid params' do
      expect{ invalid_request }.to_not change(Link, :count)
    end
  end
end
