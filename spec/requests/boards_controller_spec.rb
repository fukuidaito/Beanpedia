require 'rails_helper'

RSpec.describe BoardsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:board) { create(:board, user: user, acidity: 1, bitterness: 1, richness: 1) }

  describe 'GET #index' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'returns a successful response' do
        get boards_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get boards_path
        expect(response).to have_http_status(:found) # 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      sign_in user
      get board_path(board)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'returns a successful response' do
        get new_board_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get new_board_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'returns a successful response' do
        get edit_board_path(board)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'deletes the board' do
        board
        expect {
          delete board_path(board)
        }.to change(Board, :count).by(-1)
        expect(response).to redirect_to(boards_path)
      end
    end
  end

  describe 'GET #bookmarks' do
    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'returns a successful response' do
        get bookmarks_boards_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get bookmarks_boards_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
