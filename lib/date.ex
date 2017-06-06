defmodule LoremImpsumMd.Date do

  def now do
    now = DateTime.utc_now()
    "#{year(now)}-#{month(now)}-#{day(now)} #{hour(now)}:#{minute(now)}:#{second(now)}"
  end

  def today do
    now = DateTime.utc_now()
    "#{year(now)}-#{month(now)}-#{day(now)}"
  end

  def second(date_time) do
    date_time.second
    |> Integer.to_string
    |> String.rjust(2, ?0)
  end

  def minute(date_time) do
    date_time.minute
    |> Integer.to_string
    |> String.rjust(2, ?0)
  end

  def hour(date_time) do
    date_time.hour
    |> Integer.to_string
    |> String.rjust(2, ?0)
  end

  def year(date_time) do
    date_time.year
    |> Integer.to_string
    |> String.rjust(4, ?0)
  end

  def month(date_time) do
    date_time.month
    |> Integer.to_string
    |> String.rjust(2, ?0)
  end

  def day(date_time) do
    date_time.day
    |> Integer.to_string
    |> String.rjust(2, ?0)
  end

end