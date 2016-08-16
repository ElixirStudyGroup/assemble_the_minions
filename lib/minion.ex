defmodule AssembleTheMinions.Minion do
  use GenServer

  @moduledoc """
  See docs on GenServer for more information http://elixir-lang.org/docs/stable/elixir/GenServer.html

  I also recommend looking through the Programming Elixir book, particularly starting with page 202 "An OTP Server"
  """

  def start_link(minion_name) do
    # There are three parameters for GenServer.start_link
    # The first is __MODULE__ which is just a reference to the name of this module
    # %{name: minion_name} is a map and represents the intial state when the process is created.  It's taking the name of the minion from the supervisor
    # the final parameter is options, here we're giving a name: property which allows use to send messages to the created process by name rather than Process ID
    GenServer.start_link(__MODULE__, %{name: minion_name, count: 0}, name: minion_name)
  end

  @doc """
  Given the name of a minion, sends a :hello message to the process

  iex> AssembleTheMinions.Minion.say_hello(:stuart)
  "Hello from stuart"
  """
  def say_hello(minion_name) do
    GenServer.call(minion_name, :hello)
  end

  @doc """
  Given the minion's name, sends a :count message to the process
  """
  def count(minion_name) do
    GenServer.cast(minion_name, :count)
  end

  @doc """
  Given the minion's name sends a :current_count message to the process

  iex> AssembleTheMinions.Minion.count(:stuart)
  iex> AssembleTheMinions.Minion.current_count(:stuart)
  1
  """
  def current_count(minion_name) do
    GenServer.call(minion_name, :current_count)
  end

  @doc """
  Given the minion's name, sends a :add message with a number to the process

  iex> AssembleTheMinions.Minion.start_link(:cj)
  iex> AssembleTheMinions.Minion.count(:cj)
  iex> AssembleTheMinions.Minion.add(:cj, 3)
  iex> AssembleTheMinions.Minion.current_count(:cj)
  4
  """
  def add(minion_name, number) do
    GenServer.cast(minion_name, { :add, number })
  end

  @doc """
  Given the minion's name, sends a :subtract message with a number to the process

  iex> AssembleTheMinions.Minion.start_link(:cj)
  iex> AssembleTheMinions.Minion.count(:cj)
  iex> AssembleTheMinions.Minion.subtract(:cj, 3)
  iex> AssembleTheMinions.Minion.current_count(:cj)
  -2
  """
  def subtract(minion_name, number) do
    GenServer.cast(minion_name, { :subtract, number })
  end

  @doc """
  Given the minion's name, sends a :multiply message with a number to the process

  iex> AssembleTheMinions.Minion.start_link(:cj)
  iex> AssembleTheMinions.Minion.count(:cj)
  iex> AssembleTheMinions.Minion.count(:cj)
  iex> AssembleTheMinions.Minion.multiply(:cj, 3)
  iex> AssembleTheMinions.Minion.current_count(:cj)
  6
  """
  def multiply(minion_name, number) do
   GenServer.cast(minion_name, { :multiply, number })
  end

  @doc """
  Responsible for handling :hello messages.

  Call signatures take 3 parameters, the incoming message (which is of course pattern matched and of arbitrary complexity).

  _from is the process ID from the calling process (we're ignoring it here)

  state is the current state of hte process.  As we see in `start_link` we've initialized the process with a map, which has a `name` entry, this allows up to look that up.

  Call's reply to the caller using a tuple. which has a specific signature.

  :reply says that we are sending a reply (yeah, I know you needed the explanation)
  The second element is the message or thing we wish to return.
  The third element is state, this is how the process continues to maintain state.
  """
  def handle_call(:hello, _from, state) do
    minion_name = state.name
    {:reply, "Hello from #{minion_name}", state}
  end

  @doc """
  Returns the current count for the minion
  """
  def handle_call(:current_count, _from, state) do
    {:reply, state.count, state}
  end

  @doc """
  handle_cast receives a message and the current state.

  Cast's do not return a response, they are fire and forget.

  We return a two element tuple.

  Not that we take the existing state as the input, perform some change operations and return that as the new state.
  """
  def handle_cast(:count, state) do
    new_state = Map.update(state, :count, 1, &(&1 + 1))
    {:noreply, new_state}
  end

  @doc """
  # TODO
  # iex> TODO
  """
  def handle_cast({:add, number}, state) do
    new_state = Map.update(state, :count, 1, &(&1 + number))
    {:noreply, new_state}
  end

  @doc """
  # TODO
  # iex> TODO
  """
  def handle_cast({:subtract, number}, state) do
    new_state = Map.update(state, :count, 1, &(&1 - number))
    {:noreply, new_state}
  end

  @doc """
  # TODO
  # iex> TODO
  """
  def handle_cast({:multiply, number}, state) do
    new_state = Map.update(state, :count, 1, &(&1 * number))
    {:noreply, new_state}
  end
end
