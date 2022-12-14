function compare(a,b)
	a_is_int = (typeof(a) == Int)
	b_is_int = (typeof(b) == Int)

    println(a, ' ', b, ' ',a_is_int)
	if a_is_int && b_is_int
		return a - b

    elseif a_is_int != b_is_int
        if a_is_int
            return compare([a], b)
        else 
            compare(a, [b])
        end

    else
        for (x, y) in zip(a, b)
            res = compare(x, y)
            if res != 0
                return res
            end
        end
        return length(a) - length(b)
    end
end      



open("day13_test_input.txt") do file
    lines = eachline(file)
    packet_vector = []
    packet_subset = []
    # Parse packets 
    for line in lines
        line_list = []
        if !isempty(line)
            vector = eval(Meta.parse(line))
            push!(packet_subset, vector)
            if size(packet_subset)[1] == 2
                push!(packet_vector, packet_subset)
                packet_subset = []
            end
        end
 
    end

    packet_tracker = []
   

   
    # # Compare packet groups
    incorrect_ordering_groups = 0
    for (i,packet_group) in enumerate(packet_vector)
        group1, group2 = packet_group
        if compare(group1, group2) < 0
            incorrect_ordering_groups += i
        end
    end
    println(incorrect_ordering_groups)
end