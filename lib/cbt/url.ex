defmodule Cbt.URL do

  @base_url "cbt/"
  def generate_url() do
    string = DateTime.utc_now()
    |> DateTime.to_string()
    |> Kernel.<>("smart Zephyr")

    hash = :crypto.hash(:md5, string)
    |> Base.encode32(padding: false)
    |> String.slice(0, 10)
    |> String.downcase()

    @base_url <> hash
  end
end
