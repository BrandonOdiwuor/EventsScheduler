defmodule EventsScheduler.Event do
  use EventsScheduler.Web, :model

  schema "events" do
    field :name, :string
    field :location, :string
    field :eventtime, Ecto.DateTime
    field :creator, :string
    field :imagetag, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w(name location eventtime creator imagetag description)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
