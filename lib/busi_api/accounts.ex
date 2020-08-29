defmodule BusiApi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias BusiApi.Repo

  alias BusiApi.Accounts.Admins

  @doc """
  Returns the list of admins.

  ## Examples

      iex> list_admins()
      [%Admins{}, ...]

  """
  def list_admins do
    Repo.all(Admins)
  end

  @doc """
  Gets a single admins.

  Raises `Ecto.NoResultsError` if the Admins does not exist.

  ## Examples

      iex> get_admins!(123)
      %Admins{}

      iex> get_admins!(456)
      ** (Ecto.NoResultsError)

  """
  def get_admins!(id), do: Repo.get!(Admins, id)

  @doc """
  Creates a admins.

  ## Examples

      iex> create_admins(%{field: value})
      {:ok, %Admins{}}

      iex> create_admins(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admins(attrs \\ %{}) do
    %Admins{}
    |> Admins.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a admins.

  ## Examples

      iex> update_admins(admins, %{field: new_value})
      {:ok, %Admins{}}

      iex> update_admins(admins, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_admins(%Admins{} = admins, attrs) do
    admins
    |> Admins.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a admins.

  ## Examples

      iex> delete_admins(admins)
      {:ok, %Admins{}}

      iex> delete_admins(admins)
      {:error, %Ecto.Changeset{}}

  """
  def delete_admins(%Admins{} = admins) do
    Repo.delete(admins)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking admins changes.

  ## Examples

      iex> change_admins(admins)
      %Ecto.Changeset{data: %Admins{}}

  """
  def change_admins(%Admins{} = admins, attrs \\ %{}) do
    Admins.changeset(admins, attrs)
  end
end
