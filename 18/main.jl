function update_value(value, operator, number)
    if operator == '*'
        return value * number
    elseif operator == '+'
        return value + number
    else
        return number
    end
end

function eval_expr(line, i=1)
    value = 0
    operator = ' '
    while i <= length(line)
        if isnumeric(line[i])
            c = i
            while i < length(line) && isnumeric(line[i + 1])
                i += 1
            end
            value = update_value(value, operator, parse(Int, line[c:i]))
        elseif line[i] == '+' || line[i] == '*'
            operator = line[i]
        elseif line[i] == '('
            n, i = eval_expr(line, i+1)
            value = update_value(value, operator, n)
        elseif line[i] == ')'
            return value, i
        end
        i += 1
    end
    return value
end

function eval_expr2(line, i=1)
    values = []
    operators = []
    while i <= length(line)
        if isnumeric(line[i])
            c = i
            while i < length(line) && isnumeric(line[i + 1])
                i += 1
            end
            push!(values, parse(Int, line[c:i]))
        elseif line[i] == '+' || line[i] == '*'
            push!(operators, line[i])
        elseif line[i] == '('
            n, i = eval_expr2(line, i+1)
            push!(values, n)
        elseif line[i] == ')'
            break
        end
        i += 1
    end
    b = 0
    for (i, op) in enumerate(operators)
        if op == '+'
            values[i + 1] += values[i]
            values[i] = 0
        end
    end
    return prod(n for (i, n) in enumerate(values) if i > length(operators) || operators[i] == '*'), i
end

open("18/input.txt") do io
    exprsum = 0
    exprsum2 = 0
    for line in eachline(io)
        exprsum += eval_expr(line)
        exprsum2 += eval_expr2(line)[1]
    end
    @show exprsum
    @show exprsum2
end