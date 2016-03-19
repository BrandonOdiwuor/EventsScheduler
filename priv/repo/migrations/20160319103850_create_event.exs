defmodule EventsScheduler.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :location, :string
      add :eventtime, :datetime
      add :creator, :string
      add :imagetag, :string
      add :description, :string

      timestamps
    end

  end
end
