FactoryBot.define do
  factory :mss do
    messages { "MyString" }
    likes { 1 }
    user { nil }
  end
end
