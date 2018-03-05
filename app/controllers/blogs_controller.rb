class BlogsController < ApplicationController
 before_action :authenticate_user!, only: [:new, :create, :index, :edit, :update, :destroy]
 before_action :correct_blog_owner, only: [:edit, :update, :destroy]

 respond_to :json

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)

    if @blog.save
    redirect_to @blog
    else
    render 'new'
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def index
    @blogs = current_user.blogs.all
  end

  def edit
    @blog = Blog.find(params[:id])
    @blog.blogpicture.cache! unless @blog.blogpicture.blank?
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render 'edit'
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end

  private
  def correct_blog_owner
    @blog = Blog.find_by(id: params[:id])
    if @blog.user_id != @current_user.id
     flash[:notice] = "この記事のアクセス権限が有りません"
     redirect_to root_url
    end
  end

  def blog_params
  params.require(:blog).permit(:title, :text, :blogpicture, :user_id)
  end
end
