defmodule LoremImpsumMd.Categories do


    def tree(0, _, _) do
      []
    end

    @doc """
    Generates and array with the categories tree.

    Expectect output for `tree(3, 2, 3)` is:

    ```
    [{"1", [{"1_1", [{"1_1_1", []}, {"1_1_2", []}]}, {"1_2", [{"1_2_1", []}, {"1_2_2", []}]}]},
    {"2", [{"2_1", [{"2_1_1", []}, {"2_1_2", []}]}, {"2_2", [{"2_2_1", []}, {"2_2_2", []}]}]},
    {"3", [{"3_1", [{"3_1_1", []}, {"3_1_2", []}]}, {"3_2", [{"3_2_1", []}, {"3_2_2", []}]}]}]
    ```
    """
    @spec tree(integer, integer, integer) :: list(integer)
    def tree(num_categories, num_children, levels) do
      Enum.map(1..num_categories, fn label ->
        child_id = to_string(label)
        {child_id, generate_children(child_id, num_children, levels - 1)}
      end)
    end

    defp generate_children(_, _, 0) do
      []
    end

    defp generate_children(id, num_children, levels) do
      for label <- 1..num_children do
        child_id = id <> "_" <> to_string(label)
        {child_id, generate_children(child_id, num_children, levels - 1)}
      end
    end

end