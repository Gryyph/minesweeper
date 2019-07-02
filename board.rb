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
        self.generate_adjacent_tiles
        #self.render

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
                if tile.revealed == true
                    arr << tile.display_value
                elsif tile.flagged == true
                    arr << "F"
                else
                    arr << "*"
                end
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
        total_bomb_count = rand(1..20)
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
       @grid.each_with_index do |row,i|
            row.each_with_index do |tile, j|
                bomb_count = count_helper(i,j)
                #puts "#{i} and #{j} were successful!"
                if bomb_count == 0
                        tile.display_value = "_"
                elsif bomb_count.nil?
                        tile.display_value = "B"
                else
                        tile.display_value = bomb_count.to_s
                end
                
            end
        end
    end


    def count_helper(row_index, col_index)
        pos = [row_index, col_index]
        count = 0
        if self[pos].contains_bomb == true
            return nil
        elsif row_index < 8 #any row between first and last
            start_row = row_index - 1
            start_col = col_index - 1
            (start_row..(row_index+1)).each do |i|
                (start_col..(col_index + 1)).each do |j|
                    if self[[i,j]].nil?
                        next
                    elsif self[[i,j]].contains_bomb == true
                        count += 1
                    else
                        next
                    end
                end
            end

        else #last row
            start_row = row_index - 1
            start_col = col_index - 1
            (start_row..(row_index)).each do |i|
                (start_col..(col_index + 1)).each do |j|
                    if self[[i,j]].nil?
                        next
                    elsif self[[i,j]].contains_bomb == true
                        count += 1
                    else
                        next
                    end
                end
            end
        end

        return count
    end
end
