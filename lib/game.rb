class Game
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
        #@board.display
    end

    def won?
        WIN_COMBINATIONS.find do |a|
            @board.cells[a[0]] == @board.cells[a[1]] && @board.cells[a[1]] == @board.cells[a[2]] && @board.cells[a[0]] != " "
        end
    end

    def draw?
        @board.full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        @board.cells[won?[0]] if won?
    end

    def current_player
        @board.turn_count.even? ? player_1 : player_2
    end

    def turn
        player = current_player.move(@board)
        if @board.valid_move?(player)
            @board.update(player, current_player)
        else
            puts "Please enter a number 1-9:"
            @board.display
            turn
        end
    end

    def play
        while !over?
            turn
            @board.display
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end