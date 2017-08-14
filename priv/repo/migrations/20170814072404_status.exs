defmodule Unicorn.Repo.Migrations.Status do
  use Ecto.Migration

  def change do
    alter table(:ted_list) do
      add :status, :boolean, default: false
    end
  end
end
