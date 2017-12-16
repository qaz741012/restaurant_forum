class CommentsController < ApplicationController

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "comment was successfully created"
      redirect_to restaurant_path(@restaurant)
    else
      flash.now[:alert] = "comment was failed to created"
      render "restaurants/show"
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = Comment.find(params[:id])

    if current_user.admin?
      @comment.destroy
      redirect_to restaurant_path(@restaurant)
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
