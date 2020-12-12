open("12/input.txt") do io
    actions = []
    for line in eachline(io)
        push!(actions, (line[1], parse(Int, line[2:end])))
    end

    dir = 0
    x = y = 0
    for (act, num) in actions
        if act == 'N'
            y += num
        elseif act == 'S'
            y -= num
        elseif act == 'E'
            x += num
        elseif act == 'W'
            x -= num
        elseif act == 'R'
            dir -= num
        elseif act == 'L'
            dir += num 
        else
            x += num * cos(dir * π / 180)
            y += num * sin(dir * π / 180)
        end
    end
    @show abs(x) + abs(y)


    p = [0, 0]
    pw = [10, 1]
    for (act, num) in actions
        if act == 'N'
            pw[2] += num
        elseif act == 'S'
            pw[2] -= num
        elseif act == 'E'
            pw[1] += num
        elseif act == 'W'
            pw[1] -= num
        elseif act == 'R'
            pw = [cos(num * π / 180) sin(num * π / 180); -sin(num * π / 180) cos(num * π / 180)] * (pw - p) + p
        elseif act == 'L'
            pw = [cos(num * π / 180) -sin(num * π / 180); sin(num * π / 180) cos(num * π / 180)] * (pw - p) + p
        else
            v = pw - p
            p += num * v
            pw = p + v
        end
    end
    @show sum(abs, p)
end