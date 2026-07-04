defmodule ImageChecker do
  @moduledoc """
  Documentation for `ImageChecker`.
  """

  @spec info(binary) :: {:ok, map} | {:error, any}
  defdelegate info(file), to: ImageChecker.Backend.ReveloCli

  @spec check(binary, binary) :: {:ok, boolean} | {:error, any}
  def check(file) do
    file_type =
      file
      |> Path.extname()
      |> String.trim_leading(".")

    check(file, file_type)
  end

  @spec check(binary, binary) :: {:ok, boolean} | {:error, any}
  def check(file, file_type) do
    file_format =
      file_type
      |> String.upcase()
      |> to_format()

    with {:ok, data} <- info(file),
         format <- get_format(data) do
      {:ok, to_format(format) == file_format}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @spec get_format(map) :: binary | nil
  defp get_format(%{"media" => %{"track" => [header | _]}}), do: get_format(header)
  defp get_format(%{"Format" => format}), do: format
  defp get_format(_), do: nil

  @spec to_format(binary) :: binary
  defp to_format("MP4"), do: "MPEG-4"
  defp to_format("M4V"), do: "MPEG-4"
  defp to_format("MOV"), do: "MPEG-4"
  defp to_format("WEBM"), do: "WebM"
  defp to_format("JPG"), do: "JPEG"
  defp to_format(other), do: other
end
