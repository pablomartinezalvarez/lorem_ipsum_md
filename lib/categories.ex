defmodule LoremImpsumMd.Categories do


    def tree(0, _, _) do
      []
    end

    @doc """
    Generates and array with the categories tree.

    Expectect output for `tree(3, 2, 3)` is:

    ```
    [{"cat-1", [{"cat-1-1", [{"cat-1-1-1", []}, {"cat-1-1-2", []}]}, {"cat-1-2", [{"cat-1-2-1", []}, {"cat-1-2-2", []}]}]},
    {"cat-2", [{"cat-2-1", [{"cat-2-1-1", []}, {"cat-2-1-2", []}]}, {"cat-2-2", [{"cat-2-2-1", []}, {"cat-2-2-2", []}]}]},
    {"cat-3", [{"cat-3-1", [{"cat-3-1-1", []}, {"cat-3-1-2", []}]}, {"cat-3-2", [{"cat-3-2-1", []}, {"cat-3-2-2", []}]}]}]
    ```
    """
    @spec tree(integer, integer, integer) :: list(integer)
    def tree(num_categories, num_children, levels) do
      Enum.map(1..num_categories, fn label ->
        child_id = "cat-" <> to_string(label)
        {child_id, generate_children(child_id, num_children, levels - 1)}
      end)
    end

    defp generate_children(_, _, 0) do
      []
    end

    defp generate_children(id, num_children, levels) do
      for label <- 1..num_children do
        child_id = id <> "-" <> to_string(label)
        {child_id, generate_children(child_id, num_children, levels - 1)}
      end
    end

end