defmodule ImageChecker.Backend.ReveloBindings do
  use Rustler, otp_app: :image_checker, crate: "image_checker_revelo"

  def info(file) do
    case native_info(file) do
      {:ok, result} -> JSON.decode(result)
      err -> err
    end
  end

  # When your NIF is loaded, it will override this function.
  def native_info(_file), do: :erlang.nif_error(:nif_not_loaded)
end
