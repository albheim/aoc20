
open("02/input.txt") do io
    valid1 = 0
    valid2 = 0
    for line in eachline(io)
        n1, n2, s, str = split(line, r": | |-")
        n1, n2 = parse(Int, n1), parse(Int, n2)
        n = count(x -> x == s[1], str)
        if n1 <= n <= n2
            valid1 += 1
        end
        if xor(str[n1] == s[1], str[n2] == s[1])
            valid2 += 1
        end
    end
    @show valid1, valid2
end