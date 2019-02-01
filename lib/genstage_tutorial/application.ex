defmodule GenstageTutorial.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
  
    children = [
      worker(GenstageExample.Producer, [0]),
      worker(GenstageExample.EvenFilterer, []),
      worker(GenstageExample.OddFilterer, []),
    ]
  
    opts = [strategy: :one_for_one, name: GenstageExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
