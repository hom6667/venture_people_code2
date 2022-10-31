class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  before_action :set_post, only: %i[ show edit update destroy ]
# 투표 관련 Controller 내용 : 찬성
def upvote
  @post = Post.find(params[:id])

  #만약 '찬성' 투표를 이미 한 경우 : '찬성' 투표 취소
  if ((current_user.voted_up_on? @post) == true)
      @post.unliked_by current_user
      redirect_to(request.referrer, :notice => '해당 글의 추천을 취소하셨습니다.')
  else
      @post.upvote_by current_user
      redirect_to(request.referrer, :notice => '해당 글을 추천하셨습니다.')
  end
end

# 투표 관련 Controller 내용 : 반대
def downvote
  @post = Post.find(params[:id])
    
  #만약 '반대' 투표를 이미 한 경우 : '반대' 투표 취소
  if ((current_user.voted_down_on? @post) == true)
      @post.unliked_by current_user    
      redirect_to(request.referrer, :notice => '해당 글의 반대를 취소하셨습니다.')
  else
      @post.downvote_from current_user
      redirect_to(request.referrer, :notice => '해당 글을 반대하셨습니다.')
  end
end


  # GET /posts or /posts.json
  def index
    @posts = Post.all.reverse
  end

  # GET /posts/1 or /posts/1.json
  def show
    @new_comment  = Comment.build_from(@post, current_user.id, "")

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params[:post][:user_id] = current_user.id
      params.require(:post).permit(:title, :content, :user_id)
    end
end
