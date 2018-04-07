class BlogsController < ApplicationController
 before_action :authenticate_user!, only: [:new, :create, :index, :edit, :update, :destroy]
 before_action :correct_blog_owner, only: [:edit, :update, :destroy]
 before_action :set_blog, only: [:show, :edit, :update, :destroy]

 respond_to :json

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)

    if @blog.save
    notice
    redirect_to @blog, notice: "ブログが作成.保存されました。"
    else
    render 'new', notice: "ブログが作成.保存されませんでした。"
    end
  end

  def show

  end

  def index
    @blogs = @current_user.blogs.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
  end

  def edit

  end

  def update

    if @blog.update(blog_params)
      redirect_to @blog
      flash[:notice] = "ブログが更新されました。"
    else
      render 'edit'
    end
  end

  def destroy
    
    @blog.destroy
    redirect_to blogs_path
    flash[:notice] = "ブログが削除されました。"
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def correct_blog_owner
    @blog = Blog.find_by(id: params[:id])
    if @blog.user_id != @current_user.id
     flash[:notice] = "この記事のアクセス権限が有りません"
     redirect_to root_url
    end
  end

  def blog_params
  params.require(:blog).permit(:title, :text, {blogpicture: []}, :user_id)
  end
end
