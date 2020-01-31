class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		Comment.create(user_id: current_user.id, post_id: @post.id, comment: comment_params[:comment])
	end

	def destroy
		@post = Post.find(params[:post_id])
		comment = Comment.find(params[:id])
		comment.destroy
	end

	private
	def comment_params
		params.require(:comment).permit(:comment)
	end
end
