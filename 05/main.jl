function binary_convert(str, char1)
    n = 0
    m = 1
    for c in reverse(str)
        if c == char1
            n += m
        end
        m *= 2
    end
    return n
end

open("05/input.txt") do io
    ids = []
    for line in eachline(io)
        row = binary_convert(line[1:7], 'B')
        col = binary_convert(line[8:10], 'R')
        id = row * 8 + col
        push!(ids, id)
    end
    @show maximum(ids)
    @show filter(x -> x ∉ ids, minimum(ids):maximum(ids))
end