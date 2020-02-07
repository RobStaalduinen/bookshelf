describe User do
  
  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should have_secure_password }
    it { should validate_confirmation_of(:password) }

  end
end
