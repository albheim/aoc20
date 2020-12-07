open("03/input.txt") do io
    A = []
    for line in eachline(io)
        push!(A, line)
    end

    trees = []
    for (right, down) in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        x = y = 1
        push!(trees, 0)
        while y <= length(A)
            if A[y][x] == '#'
                trees[end] += 1
            end
            x = (x + right - 1) % length(A[y]) + 1
            y += down
        end
    end
    @show trees prod(trees)
end
