defmodule ImageChecker do
  @moduledoc """
  Documentation for `ImageChecker`.
  """

  def info(file) do
    ImageChecker.Backend.ReveloCli.info(file)
  end

  def check(file, file_type) do
    file_format = to_format(file_type)
    case info(file) do
      {:ok, %{"media" => %{"track" => [header | _]}}} ->
          {:ok, match?(%{"Format" => ^file_format}, header)}
      e -> e
    end
  end

  defp to_format("png"), do: "PNG"
  defp to_format(other), do: other
end
