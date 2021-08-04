class TicTacToe
    def initialize
        @board = [["1", "|", "2", "|", "3"],["_","|","_","|", "_"],["4", "|", "5", "|", "6"],["_","|","_","|", "_"],["7", "|","8", "|", "9"],[" ","|"," ","|"," "]]
        @choices_arry = ["1","2","3","4","5","6","7","8","9"]
        display_board
        prompt
    end
    
    def display_board
        @board.each do |element|
            element.each do |board_piece|
            print board_piece
        end
            print "\n"
        end 
    end

    def prompt
        @counter=0
        while(!check_if_winner)
            if @counter == 0
                puts "Enter your choice P1 (1-9):"
                @pick = gets.chomp
                @counter =1
                choice(@pick, "X")
            elsif @counter == 1
                puts "Enter your choice P2 (1-9):"
                @pick = gets.chomp
                @counter =0
                choice(@pick,"O")
            end
            check_if_winner
        end
        puts "Game over!"
    end

    def check_if_winner
        if @board[0][0] == @board[0][2] && @board[0][0] == @board[0][4]
            return true
        end
        if @board[0][0] == @board[2][0] && @board[0][0] == @board[4][0]
            return true
        end
        if @board[0][0] == @board[2][2] && @board[0][0] == @board[4][4]
            return true
        end
        if @board[0][4] == @board[2][2] && @board[0][4] == @board[4][0]
            return true
        end
        if @board[0][2] == @board[2][2] && @board[0][2] == @board[4][2]
            return true
        end
        if @board[0][4] == @board[2][4] && @board[0][4] == @board[4][4]
            return true
        end
        if @board[2][0] == @board[2][2] && @board[2][0] == @board[2][4]
            return true
        end
        if @board[4][0] == @board[4][2] && @board[4][0] == @board[4][4]
            return true
        end

        if @choices_arry == []
            return true
        end
    end  

    def choice(pick,play)
        if @choices_arry.include? pick
            @board.each do |inner_array|
                inner_array.each_with_index do |number,index|
                    if number == pick 
                        inner_array[index]= play 
                        @choices_arry.delete(pick)
                    end
                end
            end
        else
            puts "That was an invalid selection, please try again"
            @counter ==1? @counter = 0 : @counter = 1
        end
        display_board
    end
end

game = TicTacToe.new()