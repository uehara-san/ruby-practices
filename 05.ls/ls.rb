# frozen_string_literal: true

class ListSegments
  attr_accessor :sorted_lists

  LISTS = Dir.glob('*', base: ARGV[0])
  NUMBER_OF_COLUMN = 3.0
  NUMBER_OF_ROW = (LISTS.count / NUMBER_OF_COLUMN).ceil

  def max_length
    longest = 0
    LISTS.each do |file|
      longest = file.length if longest < file.length
    end
    longest
  end

  def transform
    sliced_lists = []
    @sorted_lists = []

    LISTS.each_slice(NUMBER_OF_ROW) { |file| sliced_lists << file }

    row = 0
    while row < NUMBER_OF_ROW
      sliced_lists.each do |file|
        @sorted_lists << if file[row].nil?
                           ' '
                         else
                           file[row]
                         end
      end
      row += 1
    end
  end

  def output
    column = 0
    @sorted_lists.each do |file|
      column += 1
      if (column % NUMBER_OF_COLUMN).zero?
        print "#{file}\n"
        column = 0
      else
        print "#{file.ljust(max_length)}  "
      end
    end
  end
end

ls = ListSegments.new
ls.transform
ls.output
