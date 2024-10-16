class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:my_rooms, :new, :create, :edit, :update, :destroy]

  def index
    @rooms = Room.all
    if params[:search].present?
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end
    
    if params[:area].present? && params[:area] != ""
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end
  end

  def show
    @room = Room.find(params[:id])
  end


  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to rooms_path, notice: '施設が作成されました。'
    else
      render :new
    end
  end

  def my_rooms
    @rooms = current_user.rooms.order(created_at: :desc)
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to rooms_path, notice: '施設が更新されました。'
    else
      render :edit
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address)
  end
end
