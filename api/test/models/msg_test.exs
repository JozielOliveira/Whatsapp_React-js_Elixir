defmodule Api.MsgTest do
  use Api.ModelCase

  alias Api.Msg

  @valid_attrs %{author: "some author", description: "some description"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Msg.changeset(%Msg{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Msg.changeset(%Msg{}, @invalid_attrs)
    refute changeset.valid?
  end
end
