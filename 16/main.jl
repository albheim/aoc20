lines = readlines("16/input.txt")

a = findfirst(==(""), lines)

ranges = []

for i in 1:a-1
    rem = findall(r"[0-9]*-[0-9]*", lines[i])
    push!(ranges, map(x -> UnitRange{Int}(parse.(Int, split(lines[i][x], "-"))...), rem))
end

my_ticket = parse.(Int, split(lines[a+2], ","))

tickets = []
for i in a+5:length(lines)
    push!(tickets, parse.(Int, split(lines[i], ",")))
end

error_rate = 0
for ticket in tickets
    for n in ticket
        if all(all(n .∉ rang) for rang in ranges)
            error_rate += n
        end
    end
end
@show error_rate

good_tickets = filter(ticket -> all(any(any(n .∈ rang) for rang in ranges) for n in ticket), tickets)

possible = ones(Int, length(ranges), length(ranges))

for ticket in [good_tickets; [my_ticket]]
    for i in eachindex(ticket)
        for j in eachindex(ranges)
            if all(ticket[i] .∉ ranges[j])
                possible[i, j] = 0
            end
        end
    end
end

found = []
for _ in 1:length(ranges)
    for i in setdiff(1:length(ranges), found)
        if sum(possible[i, :]) == 1
            j = findfirst(==(1), possible[i, :])
            possible[:, j] .= 0
            possible[i, j] = 1
            push!(found, i)
            break
        end
    end
end

my_fields = possible' * my_ticket
@show prod(my_fields[1:6])