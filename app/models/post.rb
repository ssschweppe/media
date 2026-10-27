class Post < ApplicationRecord
  STATUSES = {
    "draft" => "Черновик",
    "published" => "Опубликован",
    "archived" => "В архиве"
  }.freeze

  belongs_to :rubric
  belongs_to :category, optional: true

  mount_uploader :cover, CoverUploader

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: SLUG_FORMAT, message: :slug_format }
  validates :status, inclusion: { in: STATUSES.keys }
  validates :body, presence: true, if: :published?

  scope :published, -> { where(status: "published") }
  scope :latest, -> { order(published_at: :desc) }

  before_save :set_published_at

  def published?
    status == "published"
  end

  def status_name
    STATUSES[status]
  end

  private

  # Дата публикации ставится сама, когда пост впервые публикуют
  def set_published_at
    self.published_at ||= Time.current if published?
  end
end
