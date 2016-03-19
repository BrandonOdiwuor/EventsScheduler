ExUnit.start

Mix.Task.run "ecto.create", ~w(-r EventsScheduler.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r EventsScheduler.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(EventsScheduler.Repo)

