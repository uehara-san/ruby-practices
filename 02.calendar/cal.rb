#!/usr/bin/env ruby

require 'date'
require 'optparse'

#オプション引数を受け取る
opt = OptionParser.new
params = {}
opt.on('-y') {|v| params[:y] = v}
opt.on('-m') {|v| params[:m] = v}
opt.parse(ARGV)

#オプション引数を変数に代入
if params[:y] == true
  year = ARGV[ARGV.find_index("-y").next]
else
  year = Date.today.year
end
if params[:m] == true
  month = ARGV[ARGV.find_index("-m").next]
else
  month = Date.today.month
end

#月初日と月最終日を変数に代入
mstart = Date.new(year.to_i, month.to_i, 1)
mend = Date.new(year.to_i, month.to_i, -1)

#上部のラベル表示
puts "      " + month.to_s + "月 " + year.to_s
puts "日 月 火 水 木 金 土"

#月初日の曜日までスペースを挿入
space = 0
while space < mstart.cwday
  space += 1
  x = x.to_s + "   "
    if space == 7
      x = ""
    end
end
print x

#月初日～最終日まで日付を並べる
(mstart..mend).each do |x|
  if x.day < 10
    print " " + x.day.to_s + " "
  else x.day >= 10
    print x.day.to_s + " "
  end
  if x.saturday?
    puts "\n"
  end
end

puts "\n"
