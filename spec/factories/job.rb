FactoryGirl.define do
  factory :job do
    name "jobtest"
    location "100 harrison ave, boston, ma"
    budget "20.55"
    description "this is a super long description which will be used to test"

    employer
  end
end
