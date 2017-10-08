class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user #各コントローラで@current_userの呼び出しを可能にする

  def set_current_user
    @current_user = current_user
  end

  def user_has_posted #投稿済みの場合NEWページにアクセス出来ない
    if user_signed_in? && @current_user.post
      flash[:notice] = "既に投稿済みです"
      redirect_to(@current_user.post)
    else
      redirect_to(root_url)
      flash[:notice] = "ログインして下さい"
    end
  end


  def ensure_correct_user #自分だけがポストの編集の権限を持つ(アクション制限)
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
     flash[:notice] = "編集の権限がありません"
     redirect_to(root_url)
   end
  end
end
