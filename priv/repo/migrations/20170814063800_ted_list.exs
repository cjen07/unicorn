defmodule Unicorn.Repo.Migrations.TedList do
  use Ecto.Migration

  def change do
    create table(:ted_list) do
      add :title, :string, null: false
      add :link, :string, null: false
    end

    create unique_index(:ted_list, [:link])
  end
end
