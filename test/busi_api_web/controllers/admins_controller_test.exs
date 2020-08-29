defmodule BusiApiWeb.AdminsControllerTest do
  use BusiApiWeb.ConnCase

  alias BusiApi.Accounts
  alias BusiApi.Accounts.Admins

  @create_attrs %{
    email: "some email",
    encrypted_password: "some encrypted_password"
  }
  @update_attrs %{
    email: "some updated email",
    encrypted_password: "some updated encrypted_password"
  }
  @invalid_attrs %{email: nil, encrypted_password: nil}

  def fixture(:admins) do
    {:ok, admins} = Accounts.create_admins(@create_attrs)
    admins
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all admins", %{conn: conn} do
      conn = get(conn, Routes.admins_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create admins" do
    test "renders admins when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admins_path(conn, :create), admins: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.admins_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "encrypted_password" => "some encrypted_password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admins_path(conn, :create), admins: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update admins" do
    setup [:create_admins]

    test "renders admins when data is valid", %{conn: conn, admins: %Admins{id: id} = admins} do
      conn = put(conn, Routes.admins_path(conn, :update, admins), admins: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.admins_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "encrypted_password" => "some updated encrypted_password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, admins: admins} do
      conn = put(conn, Routes.admins_path(conn, :update, admins), admins: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete admins" do
    setup [:create_admins]

    test "deletes chosen admins", %{conn: conn, admins: admins} do
      conn = delete(conn, Routes.admins_path(conn, :delete, admins))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.admins_path(conn, :show, admins))
      end
    end
  end

  defp create_admins(_) do
    admins = fixture(:admins)
    %{admins: admins}
  end
end
