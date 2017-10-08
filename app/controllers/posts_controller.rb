class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :user_has_posted, only: [:new] #投稿済みの場合再度NEWページにアクセス出来ない
  before_action :ensure_correct_user, only: [:edit, :update, :destroy] #ポストの投稿者だけ編集可能(アプリケーションコントロ参照してください)
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] #ログインユーザーのみ可能なアクション
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post.picture.cache! unless @post.picture.blank? #carrierwaveのupdate時に画像が消えないようにキャッシュを残す。画像がある場合。
  end

  # POST /posts
  # POST /posts.json
  def create
    #@post = Post.new(post_params)
    @post = current_user.build_post(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :picture, :picture_cache, :picture2, :picture_cache2, :picture3, :picture_cache3)
    end
end
