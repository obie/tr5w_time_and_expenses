FactoryGirl.define do
  factory :user do
    name "Albert User"
    email "albert@example.com"
    password 'password'
    password_confirmation 'password'
    authorized_approver false

    factory :admin, class: User do
      name "Admin User"
      email "admin@example.com"
      authorized_approver true
    end
  end
end
