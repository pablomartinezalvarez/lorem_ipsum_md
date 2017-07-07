defmodule LoremImpsumMd.Jekyll.Generator do

  @posts_folder "_posts"

  def generate(args) do
    File.mkdir(posts_folder())
    LoremImpsumMd.Categories.tree(args[:categories], args[:children], args[:levels])
    |> populate_site(args, [])
  end

  defp posts_folder do
    @posts_folder
  end

  defp populate_site([], args, category_tokens) do
    generate_articles(args, category_tokens)
  end

  defp populate_site(categories, args, category_tokens) do
    Enum.each(categories, fn {category, subcategories} ->
      populate_site(subcategories, args, category_tokens ++ [category])
    end)
  end

  defp generate_articles(args, category_tokens) do
    num_articles = div(args[:size], args[:categories] * args[:children] * max(args[:levels] - 1, 1))
    Enum.map(1..num_articles, fn n ->
      Task.async(fn ->
        title = List.last(category_tokens) <> "-" <> "art-" <> to_string(n)
        File.write(Path.join(posts_folder(), LoremImpsumMd.Date.today() <> "-" <> title <> ".md"), LoremImpsumMd.Jekyll.ArticleTemplate.tpl(title, category_tokens, []))
      end)
    end)
    |> Enum.map(&Task.await/1)
  end

end