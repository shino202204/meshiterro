class PostCommentsController < ApplicationController
  def create
    post_image = PostImage.find(params[:post_image_id])

    # 以下２行を省略して記述する。
    # comment = PostComment.new(post_comment_params)
    # comment.user_id = current_user.id
    comment = current_user.post_comments.new(post_comment_params)

    comment.save
    redirect_to post_image_path(post_image)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
