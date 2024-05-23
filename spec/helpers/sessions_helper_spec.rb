require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }

  describe '#log_in' do
    it 'logs in the user and sets the session' do
      log_in(user)
      expect(session[:user_id]).to eq(user.id)
      expect(session[:session_token]).to eq(user.session_token)
    end
  end

  describe '#remember' do
    it 'remembers the user in persistent session' do
      remember(user)
      expect(cookies.permanent.encrypted[:user_id]).to eq(user.id)
      expect(cookies.permanent[:remember_token]).to eq(user.remember_token)
    end
  end

  describe '#logged_in?' do
    context 'when user is logged in' do
      before do
        allow(helper).to receive(:current_user).and_return(user)
      end

      it 'returns true' do
        expect(helper.logged_in?).to be_truthy
      end
    end

    context 'when no user is logged in' do
      before do
        allow(helper).to receive(:current_user).and_return(nil)
      end

      it 'returns false' do
        expect(helper.logged_in?).to be_falsey
      end
    end
  end

  describe '#forget' do
    it 'forgets the user' do
      remember(user)
      forget(user)
      expect(cookies[:user_id]).to be_nil
      expect(cookies[:remember_token]).to be_nil
    end
  end
end
