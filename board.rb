require_relative "tile"
require "byebug"

class Board

    attr_accessor :grid

    def empty_grid
        Array.new(9) do
            Array.new(9) { Tile.new() }
        end

    end

    def initialize(grid = self.empty_grid)
        @grid = grid
        self.generate_bombs
        self.generate_adacent_tiles

    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end

    #def []=(pos, value)
        #x, y = pos
        #tile = grid[x][y]
        ##end


    def render
        puts "  #{(0..8).to_a.join(" ")}"
        grid.each_with_index do |row, i|
            arr = []
            row.each do |tile|
                arr << tile.display_value
            end

            puts "#{i} #{arr.join(" ")}"
        end
    end

    def render_bombs
        puts "  #{(0..8).to_a.join(" ")}"
        grid.each_with_index do |row, i|
            arr = []
            row.each do |tile|
                if tile.contains_bomb == true
                    arr << "B"
                else
                    arr<< tile.display_value
                end
            end

            puts "#{i} #{arr.join(" ")}"
        end
    end


    def generate_bombs
        total_bomb_count = rand(1...81)
        total_bomb_count.times do 
            set_bomb
        end
    end

    def set_bomb
        row = rand(0..8)
        col = rand(0..8)
        pos = [row,col]
        #debugger
        if self[pos].contains_bomb == true
            until self[pos].contains_bomb == false
                row = rand(0..8)
                col = rand(0..8)
                pos = [row,col]
            end
            self[pos].contains_bomb = true
        else
            self[pos].contains_bomb = true
        end
         
    end

    def generate_adjacent_tiles
       
    end

end