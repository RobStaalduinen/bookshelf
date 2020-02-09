describe SessionsController do

  describe "new" do
    context "with unauthenticated user" do
      it "renders new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "with authenticated user" do
      let!(:user) { create(:user) }

      before do
        log_in_user(user)
      end

      it "redirects to users path" do
        get :new
        should redirect_to(user_path(user))
      end
    end
  end

  describe "create" do
    context "with non-existent user" do
      it "redirects to login" do
        post :create, params: { email: 'notauser@email.com' }
        should render_template(:new)
      end

      it "does not set a session token" do
        post :create, params: { email: 'notauser@email.com' }
        expect(session[:session_token]).to eq(nil)
      end
    end

    context "with incorrect password" do
      let!(:user) { create(:user) }

      it "redirects to login" do
        post :create, params: { email: user.email, password: 'badpass' }
        should render_template(:new)
      end

      it "does not set a session token" do
        post :create, params: { email: user.email, password: 'badpass' }
        expect(session[:session_token]).to eq(nil)
      end
    end

    context "with correct credentials" do
      let!(:user) { create(:user) }

      it "redirects to user path" do
        post :create, params: { email: user.email, password: user.password }

        should redirect_to(user_path(user))
      end

      it "sets a session token" do
        post :create, params: { email: user.email, password: user.password }
        expect(session[:session_token]).not_to eq(nil)
        expect(User.last.session_token).not_to eq(nil)
        expect(User.last.session_token).to eq(session[:session_token])
      end
    end
  end

  describe "log_out" do
    context "without authenticated user" do
      it "has no signed in user" do
        get :log_out
        expect(session[:session_token]).to eq(nil)
      end

      it "redirects to home" do
        get :log_out
        should redirect_to(page_path(:home))
      end
    end

    context "with authenticated user" do
      let!(:user) { create(:user) }

      before do
        post :create, params: { email: user.email, password: user.password }
      end
      
      it "removes signed in user" do
        get :log_out
        expect(session[:session_token]).to eq(nil)
      end

      it "redirects to home" do
        get :log_out
        should redirect_to(page_path(:home))
      end
    end
  end
end
