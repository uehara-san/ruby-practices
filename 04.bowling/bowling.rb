# frozen_string_literal: true

scores = []
ARGV[0].gsub('X', '10').split(',') { |x| scores << x.to_i }
zero_add_scores = []
ARGV[0].gsub('X', '10, 0').split(',') { |x| zero_add_scores << x.to_i }

split_zero_add_scores = []
zero_add_scores.each_slice(2) { |x| split_zero_add_scores << x }

last_frame_flag = false
last_frame_flag = true if split_zero_add_scores.first[0] == 10
last_frame_flag = true if split_zero_add_scores.first(2)[1][0] != 10 && split_zero_add_scores.first(2)[1].sum == 10

last_frame = []
case last_frame_flag
when true
  last_frame << scores.last(3)
when false
  last_frame << scores.last(2)
end

join_frame = split_zero_add_scores.first(9) + last_frame
hash = {}
key_number = 0
join_frame.each do |x|
  key_number += 1
  hash[key_number] = x
end

knock_down_pin = 0
(1..10).each { |x| knock_down_pin += hash[x].sum }

add_score = 0
count = 0
(1..10).each do |x|
  count += 1
  break if count == 10

  if hash[x].sum == 10 && hash[x][0] != 10
    add_score += hash[x.next][0]
  elsif hash[x][0] == 10
    if hash[x.next][0] != 10
      add_score += hash[x.next][0] + hash[x.next][1]
    elsif hash[x.next][0] == 10 && count <= 8
      add_score += hash[x.next][0] + hash[x.next.next][0]
    elsif hash[x.next][0] == 10 && count >= 9
      add_score += hash[x.next][0] + hash[x.next][0]
    end
  end
end

p knock_down_pin + add_score
