defmodule LoremImpsumMd.CLI do

  @glayu "glayu"
  @jekyll "jekyll"
  @hugo "hugo"

  def main(args) do
    args
    |> parse_args
    |> generate_site
  end

  defp parse_args(args) do
    {opts, _, _} = OptionParser.parse(args,
      switches: [categories: :integer, children: :integer, levels: :integer, platform: :string, size: :integer],
      aliases: [C: :categories, c: :children, l: :levels, p: :platform, s: :size]
     )
    opts
  end

  defp generate_site(opts) do
    case opts[:platform] do
      @glayu -> LoremImpsumMd.Glayu.Generator.generate(opts)
      @jekyll -> LoremImpsumMd.Jekyll.Generator.generate(opts)
      nil -> LoremImpsumMd.Glayu.Generator.generate(opts)
    end
  end

end