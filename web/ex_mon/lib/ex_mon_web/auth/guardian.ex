defmodule ExMonWeb.Auth.Guardian do
  alias ExMon.{Repo, Trainer}
  use Guardian, otp_app: :ex_mon

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> ExMon.fetch_trainer()
  end

  def authenticate(%{"id" => trainer_id, "password" => trainer_password}) do
    case Repo.get(Trainer, trainer_id) do
      nil -> {:error, "Trainer not found!"}
      trainer -> validate_password(trainer, trainer_password)

    end
  end

  def validate_password( %Trainer{password_hash: hash} = trainer, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(trainer)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(trainer) do
    {:ok, token, _claims} = encode_and_sign(trainer)
    {:ok, token}
  end
end
