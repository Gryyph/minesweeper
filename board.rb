require_relative "tile"


class Board

    attr_accessor :grid

    def empty_grid
        Array.new(9) do
            Array.new(9) { Tile.new() }
        end

    end

    def generate_bombs
        


    end


    def initialize(grid = self.empty_grid)
        @grid = grid
        @grid.generate_bombs

    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end

    def []=(pos, value)
        x, y = pos
        tile = grid[x][y]
        tile.value = value
    end


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










end