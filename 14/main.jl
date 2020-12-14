function writevalues!(mem, addr::Vector{Char}, val)
    if 'X' ∉ addr
        mem[String(addr)] = val
    end
    for i in eachindex(addr)
        if addr[i] == 'X'
            addr[i] = '0'
            writevalues!(mem, addr, val)
            addr[i] = '1'
            writevalues!(mem, addr, val)
            addr[i] = 'X'
            break
        end
    end
end

function applymask(mask, val)
    newval = Char[]
    for i in eachindex(mask)
        if mask[end + 1 - i] == '0' 
            if (val >> (i-1)) & 1 == 1
                push!(newval, '1')
            else
                push!(newval, '0')
            end
        else
            push!(newval, mask[end + 1 - i])
        end 
    end
    return reverse(newval)
end

open("14/input.txt") do io
    ormask = 0
    andmask = 2^36-1
    mask = ""
    mem = Dict()
    mem2 = Dict()
    for line in eachline(io)
        type, val = split(line, " = ")
        if type == "mask"
            andmask = 2^36-1-sum(x -> 2^(first(x)-1), findall("0", reverse(val)))
            ormask = sum(x -> 2^(first(x)-1), findall("1", reverse(val)))
            mask = val
        else
            loc = parse(Int, match(r"\[[0-9]*\]", type).match[2:end-1])
            mem[loc] = (parse(Int, val) & andmask) | ormask 
            writevalues!(mem2, applymask(mask, loc), parse(Int, val))
        end
    end
    @show sum(values(mem))
    @show sum(values(mem2))
end