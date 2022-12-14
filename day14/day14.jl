open("day14_test_input.txt") do file
    lines = map(x -> split(x, " ->"), readlines(file))

    # Parse the rock positions
    combined_rock_vector = []
    min_x, max_y, max_x, = Inf, 0, 0
    for line in lines
        rock_vector = []
        for pos in line
            x, y = map(x->parse(Int, x), split(strip(pos), ','))
            # Grab the extents
            if x > max_x
                max_x = x
            end
            if x < min_x
                min_x = x
            end
            if y > max_y
                max_y = y
            end
            # Push to rock vector
            push!(rock_vector, (x,y))
        end

        # Create cartesian indices
        for (i,pos) in enumerate(rock_vector)
            if i < length(rock_vector)
                # Sort the rock vectors to be increasing
                sorted_rock_vector = sort(sort([pos, rock_vector[i+1]]), by = x -> x[2])
                # Create cartesian indices
                y_idxs = range(sorted_rock_vector[1][1],sorted_rock_vector[2][1])
                x_idxs = range(sorted_rock_vector[1][2],sorted_rock_vector[2][2])
                push!(combined_rock_vector, collect(map(x -> CartesianIndex(x),  Iterators.product(x_idxs, y_idxs))))
            end
        end
    end

    # Create Matrix based on extents
    cave_matrix = zeros((1+max_x-min_x, 1+max_y))
    for rock_vec in combined_rock_vector
        for rock_pos in rock_vec
            cave_matrix[rock_pos - CartesianIndex(0, min_x - 1)] = 1
        end
    end

    display(cave_matrix)
end