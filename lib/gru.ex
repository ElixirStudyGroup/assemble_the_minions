defmodule AssembleTheMinions.Gru do
  import Supervisor.Spec
  @default_minions Application.get_env(:assemble_the_minions, :default_minions)

  @moduledoc """
  Gru is the module reponsible for supervising minions.

  This supervisor process is given the name atom :gru.  This allows us
  to look up the process ID using `Process.whereis(:gru)`
  """

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: :gru)
  end

  def init(_args) do
    # This is here to give some insight into what's going on
    # The @default_minions is an attribute that is looked up from
    # config.exs and is a list
    IO.puts("Minions, assemble!")
    IO.inspect(@default_minions)

    children = Enum.map(@default_minions, fn minion_name ->
      worker(AssembleTheMinions.Minion, [minion_name], id: minion_name)
    end)

    supervise(children, strategy: :one_for_one)
  end

end
