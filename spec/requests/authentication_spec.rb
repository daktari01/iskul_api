require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  let(:admin) { Fabricate(:admin) }
  let(:url) { 'admin/login' }
  let(:params) do
    {
      admin: {
        username: admin.username,
        email:admin.email,
        password: admin.password
      }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JWT token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before { post url }

    it 'returns anauthorized status' do
      expect(response.status).to eq 401
    end
  end
end

RSpec.describe 'DELETE /logout', type: :request do
  let(:url) { '/logout' }

  it 'returns 204, no content' do
    delete url
    expect(reponse).to have_http_status(204)
  end
end
