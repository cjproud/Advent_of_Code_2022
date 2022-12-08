open("day8_input.txt") do file
    trees_visible = 0
    best_scenic_score = 0
    lines = map(x->[parse(Int,sub_x) for sub_x in x], readlines(file))
    tree_matrix = mapreduce(permutedims, vcat, lines)
    # Grab tree edge size
    edge_size = size(tree_matrix[:])[1] -  ((size(tree_matrix)[1]+1) - 3) ^ 2
    trees_visible += edge_size
    
    # Only iterate through the interior
    for i in 2:size(tree_matrix)[1]-1
        for j in 2:size(tree_matrix)[2]-1
            # Grab current tree size
            current_tree_size = tree_matrix[i,j]   
            # Check visibility
            if any([all(x -> x < current_tree_size, tree_matrix[i,j+1:end]), all(x -> x < current_tree_size, tree_matrix[i,1:j-1]), all(x-> x < current_tree_size, tree_matrix[1:i-1,j]), all(x-> x < current_tree_size, tree_matrix[i+1:end,j])])
                trees_visible += 1
            end
        end
    end

    # Part 2: Iterate through every tree
    for i in 1:size(tree_matrix)[1]
        for j in 1:size(tree_matrix)[2]
            # Grab current tree size
            current_tree_size = tree_matrix[i,j]   
            current_scenic_score = 1
    
            # Looking right
            right = something(findfirst(>=(current_tree_size), tree_matrix[i,j+1:end]), length(tree_matrix[i,j+1:end]))
            
            # Left
            left = something(findfirst(>=(current_tree_size), reverse!(tree_matrix[i,1:j-1])), length(tree_matrix[i,1:j-1]))

            # Up
            up = something(findfirst(>=(current_tree_size), reverse!(tree_matrix[1:i-1,j])), length(tree_matrix[1:i-1,j]))

            # Down
            down = something(findfirst(>=(current_tree_size), tree_matrix[i+1:end,j]), length(tree_matrix[i+1:end,j]))

            # Grab the scenic score
            current_scenic_score = right*left*up*down
            if current_scenic_score > best_scenic_score
                best_scenic_score = current_scenic_score
            end

        end
    end
    println(trees_visible)
    println(best_scenic_score)
end
