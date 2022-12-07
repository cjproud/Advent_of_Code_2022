open("day7_input.txt") do file
    lines = eachline(file)
    dir_dict = Dict()
    current_dir = ""

    # Populate the dir structure and size
    for line in lines
        # Check if we're dealing with a command
        if occursin('$', line)
            # Track the current dir
            if occursin("cd", line) && isempty(current_dir)
                current_dir = split(line, "cd ")[2]
                dir_dict[current_dir] = 0
            elseif occursin("cd", line) && !occursin("..", line)
                current_dir = current_dir * '-' * split(line, "cd ")[2]
                dir_dict[current_dir] = 0
            elseif occursin("cd", line) && occursin("..", line)
                current_dir = current_dir[1:findlast('-',current_dir)-1]
            end
        elseif !occursin("dir", line)
            dir_dict[current_dir] += parse(Int, split(line, " ")[1])
        end
    end

    # Evaluate the size
    v_total = 0
    # Space needed/avail
    space_needed = 30000000
    space_available = 70000000
    current_minimum = Inf
    current_minimum_dir_size = 0
    space_to_delete = 0
    total_space_used = 0

    for (k,v) in sort(collect(dir_dict), by=x->x[1])

        # Keep track of the subtotal
        sub_total = 0

        # Append the filesizes within that directory
        sub_total += v

        # Check if the dir is a superior dir of another, if so, append that subdir filesize total.
        for _k in keys(dir_dict)
            if occursin(k, _k) && (k != _k)
                sub_total += dir_dict[_k]
            end
        end

        # Finally, if the total of that dir and the subdirs is less than the constraint, append to overall total.
        if sub_total <= 100000
            v_total += sub_total
        end

        # Part2: Grab total space used
        if k == "/"
            total_space_used += sub_total
            space_to_delete = space_needed - (space_available - total_space_used)
        end

      
        # Part2: Check if constraints are met.
        difference = sub_total - space_to_delete
        if (difference > 0) && (difference < current_minimum)
            current_minimum = difference
            current_minimum_dir_size = sub_total
        end
    end
    println("Part1: $(v_total)")
    println("Part2: $(current_minimum_dir_size)")
end