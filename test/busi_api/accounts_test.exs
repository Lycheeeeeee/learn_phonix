defmodule BusiApi.AccountsTest do
  use BusiApi.DataCase

  alias BusiApi.Accounts

  describe "admins" do
    alias BusiApi.Accounts.Admins

    @valid_attrs %{email: "some email", encrypted_password: "some encrypted_password"}
    @update_attrs %{email: "some updated email", encrypted_password: "some updated encrypted_password"}
    @invalid_attrs %{email: nil, encrypted_password: nil}

    def admins_fixture(attrs \\ %{}) do
      {:ok, admins} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_admins()

      admins
    end

    test "list_admins/0 returns all admins" do
      admins = admins_fixture()
      assert Accounts.list_admins() == [admins]
    end

    test "get_admins!/1 returns the admins with given id" do
      admins = admins_fixture()
      assert Accounts.get_admins!(admins.id) == admins
    end

    test "create_admins/1 with valid data creates a admins" do
      assert {:ok, %Admins{} = admins} = Accounts.create_admins(@valid_attrs)
      assert admins.email == "some email"
      assert admins.encrypted_password == "some encrypted_password"
    end

    test "create_admins/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_admins(@invalid_attrs)
    end

    test "update_admins/2 with valid data updates the admins" do
      admins = admins_fixture()
      assert {:ok, %Admins{} = admins} = Accounts.update_admins(admins, @update_attrs)
      assert admins.email == "some updated email"
      assert admins.encrypted_password == "some updated encrypted_password"
    end

    test "update_admins/2 with invalid data returns error changeset" do
      admins = admins_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_admins(admins, @invalid_attrs)
      assert admins == Accounts.get_admins!(admins.id)
    end

    test "delete_admins/1 deletes the admins" do
      admins = admins_fixture()
      assert {:ok, %Admins{}} = Accounts.delete_admins(admins)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_admins!(admins.id) end
    end

    test "change_admins/1 returns a admins changeset" do
      admins = admins_fixture()
      assert %Ecto.Changeset{} = Accounts.change_admins(admins)
    end
  end
end
