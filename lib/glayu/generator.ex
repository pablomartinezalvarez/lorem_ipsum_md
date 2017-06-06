defmodule LoremImpsumMd.Glayu.Generator do

  @source_folder "source"
  @posts_folder "_posts"

  def generate(args) do
    File.mkdir(@source_folder)
    generate_categories_tree(args[:categories], args[:children], args[:levels])
    |> populate_site(Path.join(@source_folder, @posts_folder), args, [])

  end

  defp populate_site([], root, args, category_tokens) do
    File.mkdir(root)
    generate_articles(root, args, category_tokens)
  end

  defp populate_site(categories, root, args, category_tokens) do
    File.mkdir(root)
    Enum.each(categories, fn {category, subcategories} ->
      populate_site(subcategories, Path.join(root, category), args, category_tokens ++ [category])
    end)
  end

  defp generate_articles(root, args, category_tokens) do
    num_articles = div(args[:size], args[:categories] * args[:children] * (args[:levels] - 1))
    Enum.map(1..num_articles, fn n ->
      Task.async(fn ->
        title = "art_" <> List.last(category_tokens) <> "_" <> to_string(n)
        File.write(Path.join(root, title <> ".md"), LoremImpsumMd.Glayu.ArticleTemplate.tpl(title, category_tokens, []))
      end)
    end)
    |> Enum.map(&Task.await/1)
  end

  defp generate_categories_tree(0, _, _) do
    []
  end

  # Generates and array with the categories tree expected on the souce/_posts folder of the glayu project:
  #
  # Expectect output for `generate_categories_tree(3, 2, 3)` is:
  #
  # ```
  # [{"1", [{"1_1", [{"1_1_1", []}, {"1_1_2", []}]}, {"1_2", [{"1_2_1", []}, {"1_2_2", []}]}]},
  # {"2", [{"2_1", [{"2_1_1", []}, {"2_1_2", []}]}, {"2_2", [{"2_2_1", []}, {"2_2_2", []}]}]},
  # {"3", [{"3_1", [{"3_1_1", []}, {"3_1_2", []}]}, {"3_2", [{"3_2_1", []}, {"3_2_2", []}]}]}]
  # ```
  defp generate_categories_tree(num_categories, num_children, levels) do
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