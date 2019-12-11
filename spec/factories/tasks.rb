FactoryBot.define do
  factory :task do
    task_name {'Factoryで作ったタスクネーム1'}
    detail {'Factoryで作った詳細1'}
    deadline {Time.now}
    status {"未着手"}
  end

  factory :second_task, class: Task do
    task_name {'Factoryで作ったタスクネーム２' }
    detail {'Factoryで作った詳細２'}
    deadline {Time.now}
    status {"完了"}
  end

  factory :third_task, class: Task do
    task_name {'Factoryで作ったタスクネーム3' }
    detail {'Factoryで作った詳細3'}
    deadline {Time.now}
    status {"着手中"}
  end

end
