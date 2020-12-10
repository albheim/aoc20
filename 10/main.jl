function validcombinations(n)
    n == 0 && return 1
    count = 0
    for i in 1:min(n, 3)
        count += validcombinations(n - i)
    end
    return count
end

open("10/input.txt") do io
    voltages = Int[0]
    for line in eachline(io)
        push!(voltages, parse(Int, line))
    end
    push!(voltages, maximum(voltages) + 3)

    vdiffs = diff(sort(voltages)) # We only have 1s and 3s (not sure if we are supposed to use this but I will)

    @show count(==(1), vdiffs) * count(==(3), vdiffs)

    threeidxs = findall(==(3), vdiffs)
    onesequences = diff([0; threeidxs]) .- 1 # Know last is a three step so don't need to check for that
    validcomb = prod(validcombinations.(onesequences)) # Each sequence of 1's gives 2^length of 1-seq number of combinations
    @show validcomb
end