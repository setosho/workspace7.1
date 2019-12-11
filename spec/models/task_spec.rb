require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do

  it "task_nameが空ならバリデーションが通らない" do
    task = Task.new(task_name: '', detail: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "detailが空ならバリデーションが通らない" do
    task = Task.new(task_name: '失敗テスト2', detail: '')
    expect(task).not_to be_valid
  end

  it "task_nameとdetailに内容が記載されていればバリデーションが通る" do
    task = Task.new(task_name: '成功テスト', detail: '成功テスト')
    expect(task).to be_valid
  end

  it 'タスクを絞り込めるかどうかのテスト' do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task, status: "完了")
    FactoryBot.create(:third_task, status: "着手中")
    expect_task = FactoryBot.create(:second_task, status: "完了")
    result = Task.search(task: {task_name_key: "Factoryで作ったタスクネーム２", status_key: "完了"})
  end
end
