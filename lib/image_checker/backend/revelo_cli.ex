defmodule ImageChecker.Backend.ReveloCli do
  def info(file) do
    exe = System.find_executable("revelo")
    run(exe, ["--json", file])
  end


  defp run(exe, args) do
    case System.cmd(exe, args) do
      {out, 0} -> JSON.decode(out)
      {err, _} -> {:error, err}
    end
  end
end
