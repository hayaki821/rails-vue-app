# 単純なキーとバリューを返す
# json.set! :tweet do
#     json.text, "テキスト"
#   end
# {"tweet": {"text": "テキスト"} }
json.set! :tasks do
    # 配列を回して値を返すことができる
    json.array! @tasks do |task|
        # 引数のオブジェクトの中身を指定して返すことができる
        json.extract! task, :id, :name, :is_done, :created_at, :updated_at
    end
end

# json.tweet do
#     json.array! @tweets, :title, :text
# end
# {"tweet": [{"title": "タイトル1", "text": "テキスト1" }, {"title": "タイトル2",  "text": "テキスト2"}] }

# json.extract! @tweet, :text, :title
# {"text": "テキスト", "title": "タイトル"}