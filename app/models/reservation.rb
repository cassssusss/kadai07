class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # バリデーション
  validates :check_in, :check_out, :guests, presence: true
  validates :guests, numericality: { greater_than: 0 } 

  validate :check_in_date_cannot_be_in_the_past
  validate :check_out_after_check_in

  private

  def check_in_date_cannot_be_in_the_past
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, "は本日以降の日付である必要があります")
    end
  end

  def check_out_after_check_in
    if check_in.present? && check_out.present? && check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付である必要があります")
    end
  end
end
