defmodule BusiApiWeb.AdminView do
  use BusiApiWeb, :view
  alias BusiApiWeb.AdminView

  def render("index.json", %{admins: admins}) do
    %{data: render_many(admins, AdminView, "admin.json")}
  end

  def render("show.json", %{admin: admin}) do
    %{data: render_one(admin, AdminView, "admin.json")}
  end

  def render("admin.json", %{admin: admin, token: token}) do
    %{
      email: admin.email,
      token: token
    }
  end
end
