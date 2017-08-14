defmodule Unicorn.Repo do
  use Ecto.Repo,
    otp_app: :unicorn

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :supervisor,
      restart: :permanent
    }
  end

end