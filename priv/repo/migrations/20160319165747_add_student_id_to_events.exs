defmodule EventsScheduler.Repo.Migrations.AddStudentIdToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :student_id, references(:students)
    end
    create index(:events, [:student_id])
  end
end
