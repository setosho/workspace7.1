FactoryBot.define do
  factory :task do
    task_name {'Factoryで作ったタスクネーム1'}
    detail {'Factoryで作った詳細1'}
  end

  factory :second_task, class: Task do
    task_name {'Factoryで作ったタスクネーム２' }
    detail {'Factoryで作った詳細２'}
  end
end
