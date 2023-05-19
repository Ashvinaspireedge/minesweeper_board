class BoardsController < ApplicationController
  
  # This will list all the boards 
  def index
    if params[:view_all].present? && params[:view_all] == "true" 
      @boards = Board.all.order(created_at: :desc)
    else   
      @boards = Board.all.order(created_at: :desc).limit(10)
    end

  end

  def new
    @user = User.new
    @user.boards.build
  end

  # This method will first create a user with given email and then it will generate board for that user.
  def create
    @user = User.find_or_initialize_by(email: board_params[:email])
    if @user.update(board_params)
      @board = @user.boards.last
      redirect_to board_path(@board.id)
    else
      render :new
    end
  end

  # This will display the board details.
  def show
    @board = Board.find(params[:id])
  end

  private 
  def board_params 
    params.require(:user).permit(:email, boards_attributes: [:name, :width, :height, :mines])
  end
end
