class ReservationsController < ApplicationController
  def new
    if params[:room_id]
      @room = Room.find(params[:room_id])
      @reservation = @room.reservations.build
    else
      @reservation = Reservation.new
    end
  end

  def index
    if current_user.nil?
      redirect_to new_user_session_path, alert: "ログインしてください。"
    else
      if params[:room_id]
        @room = Room.find(params[:room_id])
        if params[:filter] == "past"
          @reservations = @room.reservations.where("check_out < ?", Date.today)
        elsif params[:filter] == "upcoming"
          @reservations = @room.reservations.where("check_in >= ?", Date.today)
        else
          @reservations = @room.reservations
        end
      else
        if params[:filter] == "past"
          @reservations = current_user.reservations.where("check_out < ?", Date.today)
        elsif params[:filter] == "upcoming"
          @reservations = current_user.reservations.where("check_in >= ?", Date.today)
        else
          @reservations = current_user.reservations
        end
      end
    end
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user
  
    if @reservation.save
      redirect_to @reservation, notice: '予約が完了しました。'
    else
      render :new
    end
  end
  

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_user_registration_path, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: '予約がキャンセルされました。'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guests)
  end
end
