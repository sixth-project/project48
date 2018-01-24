class BlogsController < ApplicationController

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
    @blogs = Blog.all
  end

  def edit
    @blog = Blog.find(params[:id])
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

  def upload_image #TinyMCEの画像のアップロード
    image = Blog.create params.permit(:file, :alt, :hint )

    render json: {
      image: {
        url: image.file.url
      }
    }, content_type: "text/html"
  end


  private

  def blog_params
  params.require(:blog).permit(:title, :text, :file, :hint, :alt)
  end
end
