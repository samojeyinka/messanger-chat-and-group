require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, params: { user: { username: 'testuser', password: 'password', confirm_password: 'password' } }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: { username: 'testuser', password: 'password', confirm_password: 'password' } }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new User' do
        expect {
          post :create, params: { user: { username: 'testuser', password: 'password', confirm_password: 'wrong_password' } }
        }.to_not change(User, :count)
      end
    end
  end

  describe 'POST #signin' do
    context 'with valid username and password' do
      it 'redirects to the user profile' do
        user = User.create(username: 'testuser', password: 'password', confirm_password: 'password')
        post :signin, params: { user: { username: 'testuser', password: 'password' } }
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid username or password' do
      it 'renders the signin page' do
        post :signin, params: { user: { username: 'testuser', password: 'wrong_password' } }
        expect(response).to render_template('signin')
      end
    end
  end
end
