FactoryBot.define do
  factory :user do
    name                      { 'Test User' }
    email                     { 'test@user.com' }
    password                  { 'abc123' }
    password_confirmation     { 'abc123'}

    factory :invalid_user do
      name                    { nil }
      password_confirmation   { nil }
    end

  end
end
