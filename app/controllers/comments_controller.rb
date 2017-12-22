class CommentsController < ApplicationController

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "comment was successfully created"
      redirect_to restaurant_path(@restaurant)
    else
      flash[:alert] = "comment and score cannot be blank"
      redirect_to restaurant_path(@restaurant, comment_params)
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = Comment.find(params[:id])

    if current_user.admin? or current_user == @comment.user
      @comment.destroy
      redirect_to restaurant_path(@restaurant)
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :score)
  end

end
