function cell_string = print_cell (cell)
    [rows, columns, pages] = size(cell)

    for page = 1:pages
        for column = 1:columns
            fprintf("%15s", cell{1, column, page})
        end

        fprintf("\n")

        for row = 2:rows

            fprintf("%15s", cell{row, 1, page})

            for column = 2:columns
                fprintf("%15f", cell{row, column, page})
            end

            fprintf("\n")
        end

        fprintf("\n")
    end
end
