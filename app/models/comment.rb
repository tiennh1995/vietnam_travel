class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :user, presence: true
  validates :image, presence: true
  validates :content, presence: true

  def parent
    Comment.find_by id: self.parent_id
  end

  def reply
    Comment.find_by id: self.reply_id
  end

  def reply_comments
    Comment.where(parent_id: self.id).where.not(id: self.id)
      .order id: :desc
  end
end
