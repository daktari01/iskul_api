require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/signup' }
  let(:params) do
    {
      admin: {
        username: 'dummyuser',
        email: 'user@example.com',
        password: 'password'
      }
    }
  end

  context 'when admin is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new admin' do
      expect(response.body).to match_schema('admin')
    end
  end

  context 'when admin already exists' do
    before do
      Fabricate :admin, email: params[:admin][:email]
      post url
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      expect(json['errors'].first['title']).to eq('Bad Request')
    end
  end
end
