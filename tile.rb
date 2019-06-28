class Tile

    attr_accessor :display_value, :contains_bomb, :flagged, :revealed, :neighboring_bomb_count

    def initialize()
        @display_value = "*"
        @contains_bomb = false
        @flagged = false
        @revealed = false
        @neighboring_bomb_count = nil
    end















end