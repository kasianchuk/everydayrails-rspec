require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    it 'responds successfully' do
      get :index
      expect(response).to be_successful
    end

    it 'returns a 200 response' do
      get :index
      expect(response).to have_http_status "200"
    end

    it 'responds with HTML formatted output' do
      get :index
      expect(response.content_type).to eq 'text/html'
    end
  end
end
