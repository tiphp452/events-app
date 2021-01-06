class User < ApplicationRecord
  before_destroy :check_all_events_finished

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :created_events, class_name: "Event", foreign_key: "owner_id"
  has_many :tickets
  has_many :participating_events, through: :tickets, source: :event

  private

  def check_all_events_finished
    now = Time.zone.now
    if created_events.where(":now < end_at", now: now).exists?
      errors[:base] << "公開中の未終了イベントが存在します。"
    end

    if participating_events.where(":now < end_at", now: now).exists?
      errors[:base] << "未終了の参加イベントが存在します。"
    end

    throw(:abort) unless erros.empty?
  end
end
