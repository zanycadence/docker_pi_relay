defmodule DockerPiRelayTest do
  use ExUnit.Case
  doctest DockerPiRelay

  test "greets the world" do
    assert DockerPiRelay.hello() == :world
  end
end
