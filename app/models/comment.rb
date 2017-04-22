class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :user, presence: true
  validates :image, presence: true
  validates :content, presence: true

  def reply_comments
    Comment.where(parent_id: self.id).where.not(id: self.id)
      .order id: :asc
  end

  def reply_comment
    Comment.find_by id: self.reply_id
  end
end
