defmodule EventsScheduler.Student do
  use EventsScheduler.Web, :model

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "students" do
    has_many :events, EventsScheduler.Event
    field :name, :string
    field :year, :integer
    field :email, :string
    field :encrypted_password, :string


    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @required_fields ~w(name year email password password_confirmation)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_length(:password_confirmation, min: 6)
    |> validate_confirmation(:password)
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
        |> put_change(:encrypted_password, hashpwsalt(password))
    else
      changeset
    end

  end
end
