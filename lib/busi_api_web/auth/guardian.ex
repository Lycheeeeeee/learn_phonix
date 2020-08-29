defmodule BusiApiWeb.Auth.Guardian do
  use Guardian, otp_app: :busi_api

  alias BusiApi.Accounts

  def subject_for_token(admin, _claims) do
    sub = to_string(admin.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Accounts.get_admin!(id)
    {:ok, resource}
  end

  def authenticate(email, password) do
    with {:ok, admin} <- Accounts.get_by_email(email) do
      case validate_password(password, admin.encrypted_password) do
        true ->
          create_token(admin)

        false ->
          {:error, :unauthorized}
      end
    end
  end

  defp validate_password(password, encrypted_password) do
    Comeonin.Bcrypt.checkpw(password, encrypted_password)
  end

  defp create_token(admin) do
    {:ok, token, _claims} = encode_and_sign(admin)
    {:ok, admin, token}
  end
end
