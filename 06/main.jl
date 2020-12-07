
open("06/input.txt") do io
    groups = [[]]
    for line in eachline(io)
        if length(line) == 0
            push!(groups, [])
        else
            push!(groups[end], [x for x in line])
        end
    end
    
    @show sum(map(x -> length(union(x...)), groups))
    @show sum(map(x -> length(intersect(x...)), groups))
end