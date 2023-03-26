FactoryBot.define do
  factory :sleep_record do
    user
    start_time { '12/12/2023 19:00' }
    end_time { '13/12/2023 05:00' }
  end
end
