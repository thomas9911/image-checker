defmodule ImageChecker.Backend.ReveloCli do
  @moduledoc """
  Backend module for interacting with the Revelo CLI.
  """

  @doc """
  Retrieves information about a file using the Revelo CLI.
  Returns `{:ok, decoded_json}` on success or `{:error, reason}` on failure.
  """
  def info(file) do
    exe = System.find_executable("revelo")

    if is_nil(exe) do
      raise "revelo not found in PATH, it is probably not installed, run `cargo install revelo-cli`"
    else
      run(exe, ["--json", file])
    end
  end

  defp run(nil, _args), do: {:error, "revelo binary not found"}

  defp run(exe, args) when is_binary(exe) do
    case System.cmd(exe, args, stderr_to_stdout: true) do
      {out, 0} -> JSON.decode(out)
      {out, _} -> {:error, out}
    end
  end
end
