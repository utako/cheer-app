# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "MyString"
    commentable nil
    commenter_id 1
  end
end
