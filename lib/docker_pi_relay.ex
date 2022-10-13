defmodule DockerPiRelay do
  @moduledoc """
  Documentation for `DockerPiRelay`.
  """

  use GenServer
  alias __MODULE__
  alias Circuits.I2C
  alias Relay


  defstruct [
    address: 0x10,
    bus_name: "i2c-1",
    bus_ref: nil
  ]

  @type t :: %__MODULE__{
    address: integer(),
    bus_name: String.t(),
    bus_ref: reference()
  }

  def start_link(device) do
    GenServer.start_link(__MODULE__, device)
  end

  def update_relay(pid, relay) do
    GenServer.cast(pid, {:update_relay, relay})
  end

  @impl true
  def init(%DockerPiRelay{bus_name: bus_name} = device) do
    {:ok, bus_ref} = I2C.open(bus_name)
    {:ok, %{device| bus_ref: bus_ref}}
  end

  @impl true
  def handle_cast({:update_relay, %Relay{id: id, on?: relay_state?}}, %DockerPiRelay{bus_ref: bus_ref, address: address} = device) do
    relay_value =
      if relay_state? do
        1
      else
        0
      end
    case I2C.write(bus_ref, address, <<id, relay_value>>) do
      :ok ->
        {:noreply, device}
      _ ->
        {:stop, :update_relay_failed}
    end
  end

end
