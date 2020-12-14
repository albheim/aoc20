input = readlines("13/input.txt")
time = parse(Int, input[1])
ids = split(input[2], ',')

valid = parse.(Int, filter(x -> x != "x", ids))

dur = valid - time .% valid
(minval, minidx) = findmin(dur)
@show valid[minidx] * minval

deltas = Int[]
counter = 0
for id in ids
    if id != "x"
        push!(deltas, counter)
    end
    counter += 1
end

function find((a1, d1), (a2, d2))
    m = ceil(Int, -d1 / a1)
    while (m*a1+d1-d2) % a2 != 0
        m += 1
    end
    return a1 * a2, m*a1+d1
end

x = (valid[1], -deltas[1])
for i in 2:length(valid)
    x = find(x, (valid[i], -deltas[i]))
end

@show x[2]
