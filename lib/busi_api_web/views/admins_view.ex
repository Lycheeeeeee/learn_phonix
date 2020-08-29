defmodule BusiApiWeb.AdminsView do
  use BusiApiWeb, :view
  alias BusiApiWeb.AdminsView

  def render("index.json", %{admins: admins}) do
    %{data: render_many(admins, AdminsView, "admins.json")}
  end

  def render("show.json", %{admins: admins}) do
    %{data: render_one(admins, AdminsView, "admins.json")}
  end

  def render("admins.json", %{admins: admins}) do
    %{id: admins.id,
      email: admins.email,
      encrypted_password: admins.encrypted_password}
  end
end
