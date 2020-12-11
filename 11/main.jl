function hasneighbour(A, p, pd, ignorefloor)
    while ignorefloor && all(1 .<= p .<= size(A)) && A[p...] == -1
        p .+= pd
    end
    return all(1 .<= p .<= size(A)) && A[p...] == 1
end

function occupied(A, x, y, ignorefloor) 
    directions = setdiff(Iterators.product(fill(-1:1, 2)...), [(0, 0)])
    return count(pd -> hasneighbour(A, [y, x] .+ pd, pd, ignorefloor), directions)
end

function run(A, ignorefloor, lim)
    B = similar(A)
    while A != B
        for x in 1:size(A, 2), y in 1:size(A, 1)
            if A[y, x] == 0 && occupied(A, x, y, ignorefloor) == 0
                B[y, x] = 1
            elseif A[y, x] == 1 && occupied(A, x, y, ignorefloor) >= lim
                B[y, x] = 0
            else
                B[y, x] = A[y, x]
            end
        end
        (A, B) = (B, A) 
    end
    return A
end

open("11/input.txt") do io
    A = vcat([[x == 'L' ? 0 : -1 for x in line]' for line in eachline(io)]...)

    @show count(==(1), run(copy(A), false, 4))
    @show count(==(1), run(copy(A), true, 5))
end