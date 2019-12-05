- user
 t.string "name"
 t.string "email"
 t.string "password_digest"
 t.text "profile"

- task
 t.string "task_name"
 t.text "detail"
 t.datetime "deadline"
 t.text "status"
 t.text "priority"

- label（いらないかも）

- Herokuへのデプロイ方法
 1,heroku createする
 2,git push heroku masterする
 3,heroku run rails db:migrateする(必要に応じて)
 4,アプリ名を確認しアクセスするheroku config 今回はhttps://stark-depths-47255.herokuapp.com/tasks
