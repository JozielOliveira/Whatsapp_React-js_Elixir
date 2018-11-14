defmodule Api.Msg do
  use Api.Web, :model

  schema "msg" do
    field :author, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:author, :description])
    |> validate_required([:author, :description])
  end
end
