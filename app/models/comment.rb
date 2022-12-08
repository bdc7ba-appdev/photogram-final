# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord
  belongs_to(:photo, { :required => true, :class_name => "Photo", :foreign_key => "photo_id" })
  belongs_to :user, :required => true

  def commenter
    return User.where({ :id => self.author_id }).at(0)
  end

  def photo
    return Photo.where({ :id => self.photo_id }).at(0)
  end
end
