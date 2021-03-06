# == Schema Information
#
# Table name: users
#
#  id                :bigint(8)        not null, primary key
#  name              :string(255)
#  email             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string(255)
#  remember_digest   :string(255)
#  admin             :boolean          default(FALSE)
#  activation_digest :string(255)
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  reset_digest      :string(255)
#  reset_sent_at     :datetime
#  status            :integer          default("draft"), not null
#

class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    has_many :group_users, dependent: :destroy
    has_many :groups, through: :group_users

    attr_accessor :remember_token, :activation_token, :reset_token
    before_save :downcase_email
    before_create :create_activation_digest
    validates :name, presence: true,length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    extend Enumerize
    enumerize :status, in: {非公開: 0, 公開: 1}, scope: true

    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # トークンがダイジェストと一致したらtrueを返す
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # ユーザーのログイン情報を破棄する
    def forget
        update_attribute(:remember_digest, nil)
    end

    # アカウントを有効にする
    def activate
        update_attributes(activated: true, activated_at: Time.zone.now)
        # update_attribute(:activated_at, Time.zone.now)
    end

    # 有効化用のメールを送信する
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    # パスワード再設定の属性を設定する
    def create_reset_digest
        self.reset_token = User.new_token
        update_attributes(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    end

    # パスワード再設定のメールを送信する
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    # パスワード再設定の期限が切れている場合はtrueを返す
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    # 試作feedの定義
    # 完全な実装は次章の「ユーザーをフォローする」を参照
    def feed
        # Micropost.where("user_id = ?", id)
        # Micropost.where("user_id IN (:following_ids) OR user_id = :user_id", following_ids: following_ids, user_id: id)
        following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
        Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
    end

    # ユーザーをフォローする
    def follow(other_user)
        following << other_user
    end

    # ユーザーをフォロー解除する
    def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
    end

    # 現在のユーザーがフォローしてたらtrueを返す
    def following?(other_user)
        following.include?(other_user)
    end

    # 検索機能
    def self.search(search) #ここでのself.はUser.を意味する
        if search
          where(['name LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示。User.は省略
        else
          all #全て表示。User.は省略
        end
    end
    
    private
        # メールアドレスをすべて小文字にする
        def downcase_email
            email.downcase!
        end

        # 有効化トークンとダイジェストを作成および代入する
        def create_activation_digest
            self.activation_token  = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
end
