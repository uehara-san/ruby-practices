# frozen_string_literal: true

score_new = []
score = ARGV[0].split(',')

count = 0
score.each do |x|
  count += 1
  if x == 'X' && count < 18
    score_new << 10
    score_new << 0
    count += 1
  elsif x == 'X' && count > 18
    score_new << 10
  else
    score_new << x.to_i
  end
end

score_array = []
score_new.each_slice(2) { |x| score_array << x }

frame_1to9 = score_array.first(9)
frame_last = score_array.drop(9)

frame_last_join = []
frame_last.each { |x| frame_last_join += x }
frame = frame_1to9.push frame_last_join

key = 0
hash = {}
frame.each do |x|
  key += 1
  hash[key] = x
end

knocked_down = 0
(1..10).each { |x| knocked_down += hash[x].sum }

additional_score = 0
(1..9).each do |x|
  if hash[x][0] != 10 && hash[x].sum == 10
    additional_score += hash[x.next][0]
  elsif hash[x][0] == 10
    additional_score += if hash[x.next][0] == 10 && x < 9
                          hash[x.next][0] + hash[x.next.next][0]
                        else
                          hash[x.next][0] + hash[x.next][1]
                        end
  end
end

p knocked_down + additional_score
