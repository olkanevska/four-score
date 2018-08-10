require 'spec_helper'

module FourScore # rubocop:disable Metrics/ModuleLength
  describe Board do
    let(:board) { Board.new }
    let(:small_board) { Board.new(rows: 2, columns: 2) }

    describe 'PUBLIC METHODS' do
      context '#initialize' do
        it 'defaults to 7 rows with no options' do
          expect(Board.new.grid.size).to eq 7
        end

        it 'defaults to 7 columns with no options' do
          expect(Board.new.grid.first.size).to eq 7
        end

        it 'accepts number of rows and columns' do
          board = Board.new(rows: 8, columns: 9)
          expect(board.grid.size).to eq 8
          expect(board.grid.first.size).to eq 9
        end
      end

      context '#valid_move?' do
        it 'rejects non-integer values' do
          expect(board.valid_move?('H')).to eq false
        end

        it 'rejects invalid column numbers' do
          expect(board.valid_move?(0)).to eq false
          expect(board.valid_move?(board.columns + 1)).to eq false
        end

        it 'accepts valid column numbers' do
          expect(board.valid_move?(1)).to eq true
          expect(board.valid_move?(board.columns)).to eq true
        end
      end

      context '#column_open?' do
        it 'returns true if row is available' do
          expect(board.column_open?(1)).to eq true
        end

        it 'returns false if no row is avaialable' do
          board.rows.times { board.drop_into_column(4, 'X') }
          expect(board.column_open?(4)).to eq false
        end
      end

      context '#drop_into_column' do
        it 'returns true if column is empty' do
          expect(board.drop_into_column(4, 'piece')).to eq true
        end

        it 'returns false if invalid move' do
          board.rows.times { board.drop_into_column(4, 'X') }
          expect(board.drop_into_column(4, 'X')).to eq false
        end

        it 'sets value properly on valid moves' do
          expect(board.position(4, 1)).to eq nil

          board.drop_into_column(4, 'X')
          expect(board.position(4, 1)).to eq 'X'
          expect(board.position(4, 2)).to eq nil

          board.drop_into_column(4, 'X')
          expect(board.position(4, 2)).to eq 'X'
        end
      end

      context '#victory?' do
        it 'finds horizontal lines' do
          expect(board.victory?(1, 'X')).to eq false

          3.times do |n|
            board.drop_into_column(n + 1, 'X')
            expect(board.victory?(n + 1, 'X')).to eq false
          end

          board.drop_into_column(4, 'X')
          expect(board.victory?(4, 'X')).to eq true
        end

        it 'finds vertical lines' do
          expect(board.victory?(4, 'X')).to eq false

          3.times do
            board.drop_into_column(4, 'X')
            expect(board.victory?(4, 'X')).to eq false
          end

          board.drop_into_column(4, 'X')
          expect(board.victory?(4, 'X')).to eq true
        end

        it "finds '/' diagonal lines" do
          expect(board.victory?(1, 'X')).to eq false

          board.drop_into_column(1, 'X')
          expect(board.victory?(1, 'X')).to eq false

          board.drop_into_column(2, 'O')
          board.drop_into_column(2, 'X')
          expect(board.victory?(2, 'X')).to eq false

          board.drop_into_column(3, 'O')
          board.drop_into_column(3, 'O')
          board.drop_into_column(3, 'X')
          expect(board.victory?(3, 'X')).to eq false

          board.drop_into_column(4, 'O')
          board.drop_into_column(4, 'O')
          board.drop_into_column(4, 'O')
          board.drop_into_column(4, 'X')
          expect(board.victory?(4, 'X')).to eq true
        end

        it "finds '\\' diagonal lines" do
          expect(board.victory?(4, 'X')).to eq false

          board.drop_into_column(4, 'X')
          expect(board.victory?(4, 'X')).to eq false

          board.drop_into_column(3, 'O')
          board.drop_into_column(3, 'X')
          expect(board.victory?(3, 'X')).to eq false

          board.drop_into_column(2, 'O')
          board.drop_into_column(2, 'O')
          board.drop_into_column(2, 'X')
          expect(board.victory?(2, 'X')).to eq false

          board.drop_into_column(1, 'O')
          board.drop_into_column(1, 'O')
          board.drop_into_column(1, 'O')
          board.drop_into_column(1, 'X')
          expect(board.victory?(1, 'X')).to eq true
        end
      end

      context '#draw?' do
        it 'returns false when board is open' do
          expect(small_board.draw?).to eq false
        end

        it 'returns true when board is closed' do
          small_board.drop_into_column(1, 'X')
          small_board.drop_into_column(1, 'X')
          small_board.drop_into_column(2, 'X')
          expect(small_board.draw?).to eq false

          small_board.drop_into_column(2, 'X')
          expect(small_board.draw?).to eq true
        end
      end
    end

    describe 'PRIVATE METHODS' do
      context '#find_top_piece' do
        it 'finds highest piece if column is occupied' do
          # Subtract 1 from column '4' to translate coordinate systems
          board.drop_into_column(4, 'X')
          expect(board.send(:find_top_piece, 3)).to eq board.rows - 1

          board.drop_into_column(4, 'X')
          expect(board.send(:find_top_piece, 3)).to eq board.rows - 2
        end

        it 'returns -1 if column is empty' do
          expect(board.send(:find_top_piece, 4)).to eq - 1
        end
      end

      context '#translate' do
        it 'zero-bases column indices' do
          x = Board.new.send(:trans_x, 5)
          expect(x).to eq 4
        end

        it 'alternates origin point and zero-bases row indices' do
          y = board.send(:trans_y, board.rows)
          expect(y).to eq 0

          y = Board.new.send(:trans_y, 1)
          expect(y).to eq board.rows - 1
        end
      end
    end
  end
end
