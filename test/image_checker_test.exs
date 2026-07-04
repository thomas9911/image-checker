defmodule ImageCheckerTest do
  use ExUnit.Case
  doctest ImageChecker

  @moduletag :tmp_dir

  test "checks a valid png file", %{tmp_dir: tmp_dir} do
    file_png = Path.join(tmp_dir, "test_image.png")

    File.write!(
      file_png,
      "\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D\x49\x48\x44\x52\x00\x00\x00\x01\x00\x00\x00\x01\x08\x02\x00\x00\x00\x00\x49\x44\x41\x54\x00\x00\x00\x00\x49\x45\x4E\x44\xAE\x42\x60\x82"
    )

    assert {:ok, true} = ImageChecker.check(file_png, "png")
  end

  test "checks a random byte file with png extension", %{tmp_dir: tmp_dir} do
    file_bytes = Path.join(tmp_dir, "test_bytes.png")

    File.write!(file_bytes, "not_an_image_content")

    assert {:ok, false} = ImageChecker.check(file_bytes, "png")
  end
end
