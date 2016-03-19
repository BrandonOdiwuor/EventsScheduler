defmodule EventsScheduler.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :year, :integer
      add :email, :string
      add :encrypted_password, :string

      timestamps
    end

  end
end
