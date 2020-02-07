describe UsersController do
  
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "sets a new user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "redirects to show action" do
        post :create, params: { user: attributes_for(:user) }
        should redirect_to(user_path(User.last))
      end

    end

    context "with invalid attributes" do
      it "does not create a new user" do
        expect {
          post :create, params: { user: attributes_for(:invalid_user) }
        }.not_to change(User, :count)
      end

      it "re-renders the new template" do
        post :create, params: { user: attributes_for(:invalid_user) }
        expect(response).to render_template(:new)
        
      end

    end
  end

  describe "show" do
    context "with missing user" do
      it "renders 404" do
        get :show, params: { id: 11111 }
        expect(response.status).to eq(404)
      end
    end

    context "with existing user" do
      let(:user) { create(:user) }

      it "renders the show template" do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
      end

      it "sets the user" do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end
    end
  end

end
