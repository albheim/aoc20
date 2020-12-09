open("08/input.txt") do io
    instructions = []
    for line in eachline(io)
        op, n = split(line)
        push!(instructions, (op, parse(Int, n)))
    end

    function check_termination(instructions)
        visited = []
        acc = 0
        ptr = 1
        while ptr ∉ visited
            if ptr == length(instructions) + 1
                return true, acc
            end
            push!(visited, ptr)
            op, n = instructions[ptr]
            if op == "jmp"
                ptr += n
            else
                ptr += 1
                if op == "acc"
                    acc += n
                end
            end
        end
        return false, acc
    end

    @show check_termination(instructions)

    for i in eachindex(instructions)
        op, n = instructions[i]
        op == "acc" && continue
        if op == "jmp"
            instructions[i] = ("nop", n)
            t, acc = check_termination(instructions)
            if t
                @show i, acc
                break
            end
            instructions[i] = ("jmp", n)
        else
            instructions[i] = ("jmp", n)
            t, acc = check_termination(instructions)
            if t
                @show i, acc
                break
            end
            instructions[i] = ("nop", n)
        end
    end
end