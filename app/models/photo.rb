# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  

  mount_uploader :image, ImageUploader

  has_many(:comments, { :class_name => "Comment", :foreign_key => "photo_id", :dependent => :destroy })
  has_many(:likes, { :class_name => "Like", :foreign_key => "photo_id", :dependent => :destroy })
  belongs_to(:owner, { :required => true, :class_name => "User", :foreign_key => "owner_id" })

  validates(:poster, { :presence => true })
  validates(:image, { :presence => true })

  def poster
    return User.where({ :id => self.owner_id }).at(0)
  end

  def comments
    return Comment.where({ :photo_id => self.id })
  end

  def likes
    return Like.where({ :photo_id => self.id })
  end

  def fans
    array_of_user_ids = self.likes.map_relation_to_array(:fan_id)

    return User.where({ :id => array_of_user_ids })
  end

  def fan_list
    return self.fans.map_relation_to_array(:username).to_sentence
  end

end
