class Appointment < ApplicationRecord
  belongs_to :user

  validates :user, :title, :start_date, :end_date, presence: true
  validate :end_date_cannot_be_greater_than_start_date

  private

  def end_date_cannot_be_greater_than_start_date
    errors.add(:base, 'start_date must be less than end_date') if start_date > end_date
  end
end
