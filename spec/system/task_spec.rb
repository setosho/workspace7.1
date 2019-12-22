require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    @task = FactoryBot.create(:task, task_name: 'task')
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        # テストで使用するためのタスクを作成
        #task = FactoryBot.create(:task, task_name: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
      it '検索機能でタスクを絞り込めるかどうかのテスト' do
        visit tasks_path
        fill_in 'task_name_search', with: 'task'
        click_on '検索'
        expect(page).to have_content 'task'
      end
      it '検索機能でタスクを絞り込めるかどうかのテスト2' do
        visit tasks_path
        select '未着手', from:'status_search'
        click_on '検索'
        expect(page).to have_content '未着手'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        new_task = FactoryBot.create(:task, task_name: 'new_task')
        visit tasks_path
        task_list = all('tbody tr') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end
      it 'タスクが終了期限順に並んでいるかのテスト' do
        visit tasks_path(sort_expired: "true")
        expect(Task.order("deadline").map(&:id))
      end
      it 'タスクが優先順位で並んでいるかのテスト' do
        visit tasks_path(sort_priority: "true")
        expect(Task.order(priority: :desc).map(&:id))
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        fill_in 'task[task_name]',with:'タスクの名前'
        fill_in 'task[detail]',with:'詳細'
        click_button '登録する'
        expect(page).to have_content 'タスクの名前'
        expect(page).to have_content '詳細'
      end
      it '優先度が登録できているか' do
        visit tasks_path(sort_priority: "true")
        expect(page).to have_content 'not_entered'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
         visit new_task_path
         task = Task.create!(task_name: 'タスクネーム', detail: 'ディティール')
         visit task_path(task.id)
         expect(page).to have_content 'タスクネーム'
         expect(page).to have_content 'ディティール'
       end
     end
  end
end
