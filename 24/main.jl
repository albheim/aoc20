
""" grid indexing
   -1,1  -1,3

 0,0   0,2   0,4

    0,1   0,3   0,5

 1,0   1,2   1,4
"""

function neighbours(pos)
    if iseven(pos[2])
        return [pos .+ q for q in [(0, -2), (-1, -1), (-1, 1), (0, 2), (0, 1), (0, -1)]]
    else
        return [pos .+ q for q in [(0, -2), (0, -1), (0, 1), (0, 2), (1, 1), (1, -1)]]
    end
end

function rungame(board, iter)
    for i in 1:iter
        newboard = Dict()

        for (pos, black) in board
            for p in neighbours(pos)
                if !haskey(newboard, p)
                    nblack = count(x -> get(board, x, false), neighbours(p))
                    isblack = get(board, p, false)
                    if nblack == 2 || (isblack && nblack == 1)
                        newboard[p] = true # We only care to save the black tiles
                    end
                end
            end
        end
        
        board = newboard
    end
    return board
end

open("24/input.txt") do io
    board = Dict()
    for line in eachline(io)
        p = [0, 0]
        ptr = 1
        while ptr <= length(line)
            if line[ptr] == 's' || line[ptr] == 'n'
                if isodd(p[2]) && line[ptr] == 's'
                    p[1] += 1
                elseif iseven(p[2]) && line[ptr] == 'n'
                    p[1] -= 1
                end
                ptr += 1
                if line[ptr] == 'w'
                    p[2] -= 1
                else
                    p[2] += 1
                end
            elseif line[ptr] == 'w'
                p[2] -= 2
            else
                p[2] += 2
            end
            ptr += 1
        end
        board[p] = !get(board, p, false)
    end
    @show count(values(board))
    @show count(values(rungame(board, 100)))
end