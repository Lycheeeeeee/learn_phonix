defmodule BusiApi.Directory.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :firstname, :string
    field :gmail, :string
    field :lastname, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :gmail])
    |> validate_required([:firstname, :lastname, :gmail])
  end
end
