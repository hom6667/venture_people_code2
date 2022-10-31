class CommentsController < ApplicationController
    before_action :authenticate_user!


    def create
      commentable = commentable_type.constantize.find(commentable_id)
      @comment = Comment.build_from(commentable, current_user.id, body)
      @comment.nickname = params[:comment][:nickname]
      
      respond_to do |format|
        if @comment.save
          make_child_comment
          format.html  { redirect_to(request.referrer, :notice => 'Comments have been created.') }
        else
          format.html  { redirect_to(request.referrer, :alert => 'Please write the contents of the comment.') }
        end
      end
    end
   
    def destroy
        @comment = Comment.find_by(id: params[:id])
        @comment.delete
        respond_to do |format|
          format.html { redirect_to(request.referrer, :notice => 'Comments have been deleted.')}
          format.js
        end
    end
   
    private
   
    def comment_params
      params[:comment][:nickname] = current_user.email
      params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id, :user_id, :nickname)
    end
   
    def commentable_type
      comment_params[:commentable_type]
    end
   
    def commentable_id
      comment_params[:commentable_id]
    end
   
    def comment_id
      comment_params[:comment_id]
    end
   
    def body
      comment_params[:body]
    end
   
    def make_child_comment
      return "" if comment_id.blank?
   
      parent_comment = Comment.find comment_id
      @comment.move_to_child_of(parent_comment)
    end

   
    
  end