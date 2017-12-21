module CommentsHelper
  def average_score(restaurant)
    sum = 0
    if restaurant.comments.size > 0
      restaurant.comments.each do |comment|
        sum += comment.score if comment.score != nil
      end
      (sum.to_f / restaurant.comments.size).round(1)
    else
      0
    end
  end
end
