defmodule BusiApiWeb.AdminControllerTest do
  use BusiApiWeb.ConnCase

  alias BusiApi.Accounts
  alias BusiApi.Accounts.Admin

  @create_attrs %{
    email: "some email",
    encrypted_password: "some encrypted_password"
  }
  @update_attrs %{
    email: "some updated email",
    encrypted_password: "some updated encrypted_password"
  }
  @invalid_attrs %{email: nil, encrypted_password: nil}

  def fixture(:admin) do
    {:ok, admin} = Accounts.create_admin(@create_attrs)
    admin
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all admins", %{conn: conn} do
      conn = get(conn, Routes.admin_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create admin" do
    test "renders admin when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_path(conn, :create), admin: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.admin_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "encrypted_password" => "some encrypted_password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_path(conn, :create), admin: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update admin" do
    setup [:create_admin]

    test "renders admin when data is valid", %{conn: conn, admin: %Admin{id: id} = admin} do
      conn = put(conn, Routes.admin_path(conn, :update, admin), admin: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.admin_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "encrypted_password" => "some updated encrypted_password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, admin: admin} do
      conn = put(conn, Routes.admin_path(conn, :update, admin), admin: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete admin" do
    setup [:create_admin]

    test "deletes chosen admin", %{conn: conn, admin: admin} do
      conn = delete(conn, Routes.admin_path(conn, :delete, admin))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.admin_path(conn, :show, admin))
      end
    end
  end

  defp create_admin(_) do
    admin = fixture(:admin)
    %{admin: admin}
  end
end
