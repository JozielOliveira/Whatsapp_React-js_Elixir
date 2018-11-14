defmodule Api.MensagemTest do
  use Api.ModelCase

  alias Api.Mensagem

  @valid_attrs %{author: "some author", description: "some description"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Mensagem.changeset(%Mensagem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Mensagem.changeset(%Mensagem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
