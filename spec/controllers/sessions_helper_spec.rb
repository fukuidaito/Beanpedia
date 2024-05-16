require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers # Include Devise test helpers

  let(:user) { create(:user) }

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      before do
        post :create, params: { session: { email: user.email, password: user.password } }
      end

      it 'logs in the user' do
        sign_in user
        post :create, params: { session: { email: user.email, password: user.password } }
      end

      it 'redirects to the boards path' do
        expect(response).to redirect_to(boards_path)
      end
    end

    context 'with invalid credentials' do
      before do
        post :create, params: { session: { email: user.email, password: 'invalid' } }
      end

      it 'does not log in the user' do
        expect(controller.current_user).to be_nil
      end

      it 're-renders the new template' do
        expect(response).to render_template('new')
      end

      it 'sets a flash message' do
        expect(flash.now[:danger]).to eq(I18n.t('sessions.invalid_combination'))
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in user
      delete :destroy
    end

    it 'logs out the user' do
      expect(controller.current_user).to be_nil
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to(root_url)
    end
  end
end
