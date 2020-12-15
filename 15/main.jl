nums = parse.(Int, split(readline("15/input.txt"), ","))

turn = Dict(zip(nums[1:end-1], 1:length(nums)-1))
last = nums[end]

n = 30000000
for i in length(nums):n-1
    # Short unreadable version turn[last], last = i, i - get(turn, last, i)
    new = i - get(turn, last, i)
    turn[last] = i
    last = new
end

@show last