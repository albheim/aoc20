open("07/input.txt") do io
    bags = Dict()
    for line in eachline(io)
        a, b = split(line[1:end-1], " contain ")
        a = get!(bags, a, [])
        if b != "no other bags"
            for child in split(b, ", ")
                n, name = split(child, " ", limit=2)
                if n == "1"
                    name *= "s"
                end
                get!(bags, name, [])
                push!(a, (parse(Int, n), name))
            end
        end
    end

    names = collect(keys(bags))
    n = length(names)

    golden = findfirst(==("shiny gold bags"), names)

    bagmat = zeros(Int, n, n)
    for (i, name) in enumerate(names)
        for (n, child) in bags[name]
            i2 = findfirst(==(child), names)
            bagmat[i, i2] = n
        end
    end

    ancestors = []
    queue = [golden]
    while !isempty(queue)
        a = pop!(queue)
        for i in 1:n
            if i ∉ ancestors && bagmat[i, a] > 0
                push!(ancestors, i)
                push!(queue, i)
            end
        end
    end
    @show length(ancestors)

    function countcontent(bag)
        s = 0
        for i in 1:n
            if bagmat[bag, i] != 0
                s += bagmat[bag, i] * (1 + countcontent(i))
            end
        end
        return s
    end
    @show countcontent(golden)
end