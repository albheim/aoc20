a, b = parse.(Int, readlines("25/input.txt"))

v = 1
c = 0
while v != a
    v = (7v) % 20201227
    c += 1
end

q = 1
for _ in 1:c
    q = (b * q) % 20201227
end
