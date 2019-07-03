require_relative "board"


class Game

    attr_accessor :game

    def initialize
        @game = Board.new
    end


    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            puts "Please enter a position on the board (e.g., '3,4')"
            print "> "

            begin
                pos = parse_pos(gets.chomp)
            rescue
                puts "Invalid position entered (did you use a comma?)"
                puts ""

                pos = nil
            end
        end
        pos
    end


    def parse_pos(string)
        string.split(",").map { |char| Integer(char) }
    end

    def valid_pos?(pos)
        pos.is_a?(Array) &&
            pos.length == 2 &&
        pos.all? { |x| x.between?(0, 8) }
    end

    def get_val
        val = nil
        until val && valid_val?(val)
            puts "Please enter r to reveal a tile or f to flag a tile"
            print "> "
            val = gets.chomp
        end
        val
    end

    def valid_val?(val)
        val == "r" || val == "f"
    end

    def run
        play_turn until solved? || game_over?
        system("clear")
        @game.render
        puts "Nice, you win!" if solved?
        puts "Whoops, you hit a bomb! Game over." if game_over?

    end

    def solved?
        @game.solved?
    end

    def game_over?
        @game.game_over?
    end


    def play_turn
        system("clear")
        @game.render
        pos = get_pos
        val = get_val
        reveal(pos) if val == "r"
        @game[pos].flagged = true if val == "f"

    end


    def reveal(pos)
        #debugger
        x,y = pos
        if @game[pos].display_value == "_"
            @game[pos].revealed = true
            reveal([x+1,y+1]) if x < 8 && y < 8
            reveal([x+1,y-1]) if x < 8 && y > 0
            reveal([x+1,y]) if x < 8 
            reveal([x-1,y-1]) if x > 0 && y > 0
            reveal([x-1,y]) if x > 0
            reveal([x-1,y+1]) if x > 0 && y < 8
            reveal([x,y-1]) if y > 0
            #reveal([x,y])
            
        else
            @game[pos].revealed = true
        end

    end







end