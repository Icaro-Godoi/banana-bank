defmodule BananaBank.Users.Create do
  alias BananaBank.Repo
  alias BananaBank.Users.User
  alias BananaBank.ViaCep.Client, as: ViaCepClient

  def call(%{"cep" => cep} = params) do
    with {:ok, _} <- client().call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client do
    Application.get_env(:banana_bank, :via_cep, ViaCepClient)
  end
end
