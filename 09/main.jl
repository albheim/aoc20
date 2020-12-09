function checkifsumton(numbers, n)
    numbers = sort(numbers)
    i1, i2 = 1, length(numbers)
    while i1 != i2 
        a = numbers[i1] + numbers[i2]
        if a == n
            return numbers[i1] != numbers[i2]
        elseif a < n
            i1 += 1
        else
            i2 -= 1
        end
    end
    return false
end

open("09/input.txt") do io
    numbers = []
    for line in eachline(io)
        push!(numbers, parse(Int, line))
    end

    offset = 25

    idx = findfirst(i -> !checkifsumton(numbers[i-offset:i-1], numbers[i]), offset+1:length(numbers)) + offset
    @show numbers[idx]

    i1, i2 = 1, 1
    sm = sum(numbers[i1:i2])
    while sm != numbers[idx]
        if sm > numbers[idx]
            sm -= numbers[i1]
            i1 += 1
        else
            i2 += 1
            sm += numbers[i2]
        end
    end
    @show minimum(numbers[i1:i2]) + maximum(numbers[i1:i2])
end

