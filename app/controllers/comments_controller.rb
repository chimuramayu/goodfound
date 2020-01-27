class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		Comment.create(user_id: current_user.id, post_id: @post.id, comment: comment_params[:comment])
		redirect_to post_path(@post)
	end

	def destroy
		@post = Post.find(params[:post_id])
		comment = Comment.find(params[:id])
		comment.destroy
		redirect_to post_path(@post)
	end

	private
	def comment_params
		params.require(:comment).permit(:comment)
	end
end
