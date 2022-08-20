defmodule Cbt.Accounts.Experimenter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "experimenters" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :is_admin, :boolean
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(experimenter, attrs) do
    experimenter
    |> cast(attrs, [:lastname, :firstname, :email, :is_admin])
    |> validate_required([:lastname, :email])

    # TODO: validate email
  end

  def registration_changeset(experimenter, params) do
    experimenter
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 8, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
