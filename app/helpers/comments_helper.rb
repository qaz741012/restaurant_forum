module CommentsHelper
  def average_score(restaurant)
    sum = 0
    if restaurant.comments.size > 0
      restaurant.comments.each do |comment|
        sum += comment.score
      end
      sum.to_f / restaurant.comments.size
    else
      0
    end
  end
end
