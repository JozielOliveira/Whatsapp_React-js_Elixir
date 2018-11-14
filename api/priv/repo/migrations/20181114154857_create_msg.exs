defmodule Api.Repo.Migrations.CreateMsg do
  use Ecto.Migration

  def change do
    create table(:msg) do
      add :author, :string
      add :description, :string

      timestamps()
    end
  end
end
