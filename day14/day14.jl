open("day14_input.txt") do file
    lines = map(x -> split(x, " ->"), readlines(file))

    # Parse the rock positions
    combined_rock_vector = []
    min_x, min_y, max_y, max_x, = Inf, Inf, 0, 0
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
            if y < min_y
                min_y = y
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
                x_idxs = range(sorted_rock_vector[1][2]+1,sorted_rock_vector[2][2]+1)
                y_idxs = range(sorted_rock_vector[1][1],sorted_rock_vector[2][1])
                push!(combined_rock_vector, collect(map(x -> CartesianIndex(x),  Iterators.product(x_idxs, y_idxs))))
            end
        end
    end

    # Create Matrix based on extents
    println(min_x, ' ', max_x, ' ', min_y, ' ', max_y)
    cave_matrix = zeros((1+max_y, 1+max_x-min_x))
    for rock_vec in combined_rock_vector
        for rock_pos in rock_vec
            cave_matrix[rock_pos - CartesianIndex(0, min_x - 1)] = 1
        end
    end

    # Add horizontal space
    horizontal_padding = 1000
    cave_matrix = hcat(cave_matrix, zeros(size(cave_matrix)[1], horizontal_padding))
    cave_matrix = hcat(zeros(size(cave_matrix)[1], horizontal_padding), cave_matrix)
    # Concatenate empty space and floow
    cave_matrix = vcat(cave_matrix, transpose(zeros(size(cave_matrix)[2])))
    cave_matrix = vcat(cave_matrix, transpose(ones(size(cave_matrix)[2])))

    # Change min_x by this
    min_x = min_x - horizontal_padding

    # Start sand falling
    sand_can_move = true
    sand_not_overflowing = true
    sand_units = 0
    while sand_units <= 1e5 && sand_not_overflowing
        sand_position = CartesianIndex((1,500-min_x+1))
        while sand_can_move

            # Check if we're violating bounds
            try
                # Try move down
                if cave_matrix[sand_position + CartesianIndex(1, 0)] < 1
                    sand_position =  sand_position + CartesianIndex(1, 0)
                # Down-left
                elseif cave_matrix[sand_position + CartesianIndex(1, -1)] < 1
                    sand_position =  sand_position + CartesianIndex(1, -1)
                # Down-right
                elseif cave_matrix[sand_position + CartesianIndex(1, 1)] < 1
                    sand_position =  sand_position + CartesianIndex(1, 1)
                elseif cave_matrix[sand_position] < 1
                    cave_matrix[sand_position] = 2
                    break
                elseif cave_matrix[sand_position] == 2
                    println("Full to the brim!", ' ', sand_units)
                    sand_not_overflowing = false
                    sand_can_move = false
                    break
                end
            catch
                println("Overflowing", sand_units)
                sand_not_overflowing = false
                sand_can_move = false
                break
            end
        end
        sand_units +=1
    end
end