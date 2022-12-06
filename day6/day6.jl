function packet_testing(window, line)
    is_unique = false
    i = 1
    while !(is_unique)
        packet = line[i:i+(window-1)]
        if length(intersect(packet)) == length(packet)
            is_unique = true
            return i+window-1
        else
            i += 1
        end
    end
end

open("day6_input.txt") do file
    line = readlines(file)[1]
    window = 4
    window2 = 14
    is_unique = false
    i = 1
    
    # Part 1
    println(packet_testing(window, line))
    # Part 2
    println(packet_testing(window2, line))

end
