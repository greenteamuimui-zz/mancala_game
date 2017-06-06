require 'byebug'
class Board
  attr_accessor :cups
  attr_reader :name1, :name2

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) {Array.new}
    @cups.each_with_index do |cup, i|
      next if i == 6 || i == 13
      4.times do
        cup << :stone
      end
    end
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    if !start_pos.between?(1,12) || start_pos == 6
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    # debugger
      if current_player_name == name1
        i = 0
        until @cups[start_pos].empty?
          i += 1
          v = 0
          if start_pos + i > 12
            v = start_pos + i - 14
          else
            v = start_pos + i
          end
          next if v % 13 == 0
          if @cups[start_pos].length == 1
            end_cup = v
          end
          @cups[v] << @cups[start_pos].pop
        end
      else
        i = 0
        until @cups[start_pos].empty?
          i += 1
          v = 0
          if start_pos + i > 12
            v = start_pos + i - 14
          else
            v = start_pos + i
          end
          next if v % 6 == 0
          if @cups[start_pos].length == 1
            end_cup = v
          end
          @cups[v] << @cups[start_pos].pop
        end
      end
    self.render
    self.next_turn(end_cup, current_player_name)
  end

  def next_turn(ending_cup_idx, current_player)
    if ending_cup_idx == 6 && current_player == name1
      :prompt
    elsif ending_cup_idx == 13 && current_player == name2
      :prompt
    elsif @cups[ending_cup_idx].length == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if @cups[1...6].all? {|cup| cup.empty?} || @cups[7...13].all? {|cup| cup.empty?}
    false
  end

  def winner
    if @cups[6].count == @cups[13].length
      return :draw
    else
      p @cups[6].length > @cups[13].length ? "#{name1}" : "#{name2}"
    end
  end
end
