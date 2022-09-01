#!/usr/bin/env ruby
# frozen_string_literal: true

class ListSegments
  LISTS = Dir.glob('*')
  COLUMN = 3.0
  ROW = (LISTS.count / COLUMN).ceil

  def max_length
    LISTS.max_by(&:length).length
  end

  def transform
    split_lists = []
    LISTS.each_slice(ROW) { |file| split_lists << file }

    split_lists << [''] if split_lists.count < COLUMN

    @formatted_lists = []
    index = 0
    while index < ROW
      split_lists.each do |file|
        @formatted_lists << if file[index].nil?
                              ''
                            else
                              file[index]
                            end
      end
      index += 1
    end
  end

  def output
    count = 1
    @formatted_lists.each do |file|
      if count == COLUMN
        puts file.ljust(max_length)
        count = 1
      else
        print "#{file.ljust(max_length)} "
        count += 1
      end
    end
  end
end

ls = ListSegments.new
ls.transform
ls.output
