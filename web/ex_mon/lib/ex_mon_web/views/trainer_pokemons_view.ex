defmodule ExMonWeb.TrainerPokemonsView do
  use ExMonWeb, :view
  alias ExMon.Trainer.Pokemon

  def render("create.json", %{pokemon: %Pokemon{id: id, name: name, inserted_at: inserted_at, nickname: nickname, weight: weight, types: types, trainer_id: trainer_id}}) do
    %{
      message: "Pokemon Created!",
      pokemon: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        nickname: nickname,
        weight: weight,
        types: types,
        trainer_id: trainer_id
      }
    }
  end

  def render("show.json", %{pokemon: %Pokemon{id: id, name: name, inserted_at: inserted_at, nickname: nickname, weight: weight, types: types, trainer: %{id: trainer_id, name: trainer_name}}}) do
    %{
      pokemon: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        nickname: nickname,
        weight: weight,
        types: types,
        trainer: %{
          id: trainer_id,
          name: trainer_name,
        }
      }
    }
  end

  def render("update.json", %{pokemon: %Pokemon{id: id, name: name, inserted_at: inserted_at, nickname: nickname, weight: weight, types: types, trainer_id: trainer_id}}) do
    %{
      message: "Pokemon Updated!",
      pokemon: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        nickname: nickname,
        weight: weight,
        types: types,
        trainer_id: trainer_id
      }
    }
  end
end
