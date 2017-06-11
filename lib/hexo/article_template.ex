defmodule LoremImpsumMd.Hexo.ArticleTemplate do

  def tpl(title, categories, tags) do
    """
    ---
    title: #{title}
    date: #{LoremImpsumMd.Date.now}
    author: Lorem Ipsum Markdown Generator
    categories: #{format_collection(categories)}
    tags: #{format_collection(tags)}
    ---
    Adipisci et qui quia laudantium consequuntur optio. Ex aliquam non expedita aut sint ut earum. Beatae provident nemo aut aliquam repudiandae consectetur autem.
    Molestiae deleniti explicabo dolor. Qui porro dolorum dolores optio aliquam dolores est et. Harum et excepturi laborum maiores omnis necessitatibus et doloremque.
    Qui nisi culpa numquam rem et aut dolorem. Reprehenderit atque quam est quos aspernatur aut nesciunt esse. Omnis aspernatur mollitia placeat harum dolorem et. Ut et consequuntur nihil nam modi nobis ipsum.
    Doloribus modi officia a modi. Repudiandae optio quas consequatur qui voluptates voluptates. Dolor officia voluptas molestiae quod fugiat sapiente.
    Repellendus voluptas temporibus minus ipsum accusantium nam nam. Autem a facilis voluptatem eos excepturi eligendi aspernatur animi. Veritatis officia ullam fugit nihil similique aut debitis. Non nisi dignissimos accusamus. Illo voluptatem quia aut ipsum vero neque accusamus.
    """
  end

  defp format_collection(collection) do
    Enum.reduce(collection, "", fn(item, result) ->
      result <> "\n- " <> item
    end)
  end

end