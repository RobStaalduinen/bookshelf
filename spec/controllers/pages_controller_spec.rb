describe PagesController do
  
  describe "show" do
    context "home" do
      it "renders home template" do
        get :show, params: { page: :home }
        should render_template(:home)
      end
    end

  end
end
