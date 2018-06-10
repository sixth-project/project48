class ChatRoomsController < ApplicationController
  before_action :authenticate_user!#ログインユーザーのみ可能なアクション
  before_action :limit_chatrooms, only: :new #すでにチャットを作成済みの場合はリダイレクトされる（一人一つまで)

  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def destroy
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @chat_room.destroy
    flash[:notice] = "チャットを削除しました"
    redirect_to root_path
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end

  def limit_chatrooms
    if current_user.chat_rooms.present?
      redirect_to chat_rooms_path, notice: "既にチャットが1つ存在しています。新たに作成する場合は削除してから新たに作成してください。"
    end
  end

end
