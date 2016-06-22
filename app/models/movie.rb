class Movie < ActiveRecord::Base
  has_many :reviews
  mount_uploader :image, MoviePosterUploader

  validates :title,
            presence: true

  validates :director,
            presence: true

  validates :runtime_in_minutes,
            numericality: { only_integer: true }

  validates :description,
            presence: true

  validates :image,
            presence: true

  validates :release_date,
            presence: true

  validate :release_date_is_in_the_past

  def review_average
    if reviews.empty?
      0
    else
      reviews.sum(:rating_out_of_ten) / reviews.size
    end
  end

  def self.movie_duration
    # shorter_than_90 = Movie.where('runtime_in_minutes <= 90')
    # between_90_and_180 = Movie.where(')
    # longer_than_180 = Movie.where('runtime_in_minutes >= 180')
    # # case params[:length]
    # # when 1
    # #   then @movie.where
    # # when 2
    # #   then @movie && Movie.runtime_in_minutes > 180
    # # when 3
    # #   then @movie && (Movie.runtime_in_minutes >= 90 && Movie.runtime_in_minutes <= 180)
    # # end
  end



  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, 'should be in the past') if release_date > Date.today
    end
  end
end
