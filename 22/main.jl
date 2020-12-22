lines = readlines("22/input.txt")
mid = findfirst(==(""), lines)

player1 = parse.(Int, lines[2:mid-1])
player2 = parse.(Int, lines[mid+2:end])

p1, p2 = copy(player1), copy(player2)
while !isempty(p1) && !isempty(p2)
    v = map(popfirst!, [p1, p2])
    if v[1] > v[2]
        append!(p1, v)
    else
        append!(p2, reverse(v))
    end
end

@show sum(p1 .* reverse(1:50))

function recurse(p1, p2)
    visited = []
    while !isempty(p1) && !isempty(p2)
        h = hash([p1, p2])
        h in visited && return true
        push!(visited, h)

        v = map(popfirst!, [p1, p2])
        if v[1] <= length(p1) && v[2] <= length(p2)
            p1win = recurse(p1[1:v[1]], p2[1:v[2]])
        else
            p1win = v[1] > v[2]
        end
            
        if p1win
            append!(p1, v)
        else
            append!(p2, reverse(v))
        end
    end
    return !isempty(p1)
end

p1, p2 = copy(player1), copy(player2)
p1win = recurse(p1, p2)

winner = p1win ? p1 : p2
@show sum(winner .* reverse(eachindex(winner)))
