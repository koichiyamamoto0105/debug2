class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  attachment :profile_image, destroy: false
  
  # いいね機能パターン２
  # def 
	 #  favorited_by?(book)
	 #  self.favorites.exists?(book_id: book.id)
  # end
  
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  def self.search(search,word)
    if search == "forward_match"
     @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
     @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
     @user = User.where(name: word)
    elsif search == "partial_match"
     @user = User.where("name LIKE?","%#{word}%")
    else
     @user = User.all
    end
  end
  
end
