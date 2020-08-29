defmodule BusiApiWeb.AdminController do
  use BusiApiWeb, :controller

  alias BusiApi.Accounts
  alias BusiApi.Accounts.Admin
  alias BusiApiWeb.Auth.Guardian

  action_fallback BusiApiWeb.FallbackController

  def index(conn, _params) do
    admins = Accounts.list_admins()
    render(conn, "index.json", admins: admins)
  end

  def create(conn, %{"admin" => admin_params}) do
    with {:ok, %Admin{} = admin} <- Accounts.create_admin(admin_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(admin) do
      conn
      |> put_status(:created)
      |> render("admin.json", %{admin: admin, token: token})
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, admin, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("admin.json", %{admin: admin, token: token})
    end
  end
end
