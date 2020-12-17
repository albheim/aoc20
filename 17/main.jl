inputarr = hcat([map(x -> x == '#' ? 1 : 0, collect(line)) for line in readlines("17/input.txt")]...)'
n, m = size(inputarr)

cycles = 6
A = zeros(Int, n + 2cycles, m + 2cycles, 1 + 2cycles, 1 + 2cycles)
B = similar(A)

A[cycles+1:cycles+n, cycles+1:cycles+m, cycles+1, cycles+1] = inputarr
for c in 1:cycles
    c -= 1
    c += 1
    for i in 1:size(A, 1), j in 1:size(A, 2), k in 1:size(A, 3), l in 1:size(A, 4)
        nsum = sum(A[max(1, i-1):min(size(A, 1), i+1), max(1, j-1):min(size(A, 2), j+1), max(1, k-1):min(size(A, 3), k+1), max(1, l-1):min(size(A, 3), l+1)])
        if A[i, j, k, l] == 0 &&  nsum== 3
            B[i, j, k, l] = 1
        elseif A[i, j, k, l] == 1 && 3 <= nsum <= 4
            B[i, j, k, l] = 1
        else
            B[i, j, k, l] = 0
        end
    end
    (A, B) = (B, A)
end

@show sum(A)