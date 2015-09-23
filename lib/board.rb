class Board
  attr_accessor :spaces

  def initialize
    @spaces = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def open_spaces
    @spaces.select {|space| space =~ /[0-8]/}
  end

end