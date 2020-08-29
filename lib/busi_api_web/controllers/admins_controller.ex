defmodule BusiApiWeb.AdminsController do
  use BusiApiWeb, :controller

  alias BusiApi.Accounts
  alias BusiApi.Accounts.Admins

  action_fallback BusiApiWeb.FallbackController

  def index(conn, _params) do
    admins = Accounts.list_admins()
    render(conn, "index.json", admins: admins)
  end

  def create(conn, %{"admins" => admins_params}) do
    with {:ok, %Admins{} = admins} <- Accounts.create_admins(admins_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.admins_path(conn, :show, admins))
      |> render("show.json", admins: admins)
    end
  end

  def show(conn, %{"id" => id}) do
    admins = Accounts.get_admins!(id)
    render(conn, "show.json", admins: admins)
  end

  def update(conn, %{"id" => id, "admins" => admins_params}) do
    admins = Accounts.get_admins!(id)

    with {:ok, %Admins{} = admins} <- Accounts.update_admins(admins, admins_params) do
      render(conn, "show.json", admins: admins)
    end
  end

  def delete(conn, %{"id" => id}) do
    admins = Accounts.get_admins!(id)

    with {:ok, %Admins{}} <- Accounts.delete_admins(admins) do
      send_resp(conn, :no_content, "")
    end
  end
end
