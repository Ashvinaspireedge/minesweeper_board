class Board < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :width, presence: true, numericality: { greater_than: 0 }
  validates :height, presence: true, numericality: { greater_than: 0 }
  validates :mines, presence: true, numericality: { greater_than_or_equal_to: 0 }

  serialize :cells, Array

  after_save :generate_board

  # This method is used to generate the board for given width and height and it will randomly set the mines on the generated board.
  def generate_board
    board = Array.new(height) { Array.new(width, false) }
  
    mines.times do
      row = nil
      col = nil
  
      loop do
        row = rand(height)
        col = rand(width)
        break unless board[row][col]
      end
  
      board[row][col] = true
    end
    update_column(:cells, board)
  end
  
end
