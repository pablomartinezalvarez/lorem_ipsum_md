defmodule LoremImpsumMd.Glayu.Generator do

  @source_folder "source"
  @posts_folder "_posts"

  def generate(args) do
    File.mkdir(@source_folder)
    LoremImpsumMd.Categories.tree(args[:categories], args[:children], args[:levels])
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

end