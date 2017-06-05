defmodule LoremImpsumMd.Glayu.Generator do

  def generate(args) do
    args
    |> create_site_structure
    |> generate_articles
    |> inspect
    |> IO.puts
  end

  defp create_site_structure(args) do
    generate_categories(args[:categories], args[:children], args[:levels])
    |> create_categories_folders
    args
  end

  defp generate_articles(args) do
    args
  end

  defp generate_categories(0, num_children, levels) do
    []
  end


  # Generates and array with the categories tree expected on the souce/_posts folder of the glayu project:
  #
  # Expectect output for `generate_categories(3, 2, 3)` is:
  #
  # ```
  # [{"1", [{"1_1", [{"1_1_1", []}, {"1_1_2", []}]}, {"1_2", [{"1_2_1", []}, {"1_2_2", []}]}]},
  # {"2", [{"2_1", [{"2_1_1", []}, {"2_1_2", []}]}, {"2_2", [{"2_2_1", []}, {"2_2_2", []}]}]},
  # {"3", [{"3_1", [{"3_1_1", []}, {"3_1_2", []}]}, {"3_2", [{"3_2_1", []}, {"3_2_2", []}]}]}]
  # ```
  #

  defp generate_categories(num_categories, num_children, levels) do
    Enum.map(1..num_categories, fn label ->
      child_id = to_string(label)
      {child_id, generate_children(child_id, num_children, levels - 1)}
    end)
  end

  defp generate_children(id, num_children, 0) do
    []
  end

  defp generate_children(id, num_children, levels) do
    Enum.map(1..num_children, fn label ->
      child_id = id <> "_" <> to_string(label)
      {child_id, generate_children(child_id, num_children, levels - 1)}
    end)
  end

end