defmodule Talk.Auth do

  import Ecto.Query, warn: false
  alias Talk.Repo

  alias Talk.Auth.User

  def signin(auth) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, name: auth.info.name}
    case Repo.get_by(User, email: user_params.email) do
      nil ->
        User.changeset(%User{},user_params)
        |> Repo.insert()

      user ->
        {:ok, user}
    end
  end

end
