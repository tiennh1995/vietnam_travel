namespace :db do
  desc "Import Comment"
  task comments: [:environment] do
    Image.all.each do |image|
      comment = Comment.create! user_id: 1, image_id: image.id,
        content: "きれいな写真ですね。ぜひ一度行ってきます。"
      c1 = Comment.create! user_id: 2, image_id: image.id, parent_id: comment.id,
        content: "うん。きれいな写真ですね。私もぜひ一度行ってきます。"
      Comment.create! user_id: 3, image_id: image.id, parent_id: comment.id,
        content: "うん。きれいな写真ですね。私もぜひ一度行ってきます。", reply_id: c1.id
    end
  end
end
