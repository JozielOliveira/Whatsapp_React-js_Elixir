defmodule Api.MensagemControllerTest do
  use Api.ConnCase

  alias Api.Mensagem
  @valid_attrs %{author: "some author", description: "some description"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, mensagem_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    mensagem = Repo.insert! %Mensagem{}
    conn = get conn, mensagem_path(conn, :show, mensagem)
    assert json_response(conn, 200)["data"] == %{"id" => mensagem.id,
      "author" => mensagem.author,
      "description" => mensagem.description}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, mensagem_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, mensagem_path(conn, :create), mensagem: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Mensagem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, mensagem_path(conn, :create), mensagem: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    mensagem = Repo.insert! %Mensagem{}
    conn = put conn, mensagem_path(conn, :update, mensagem), mensagem: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Mensagem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    mensagem = Repo.insert! %Mensagem{}
    conn = put conn, mensagem_path(conn, :update, mensagem), mensagem: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    mensagem = Repo.insert! %Mensagem{}
    conn = delete conn, mensagem_path(conn, :delete, mensagem)
    assert response(conn, 204)
    refute Repo.get(Mensagem, mensagem.id)
  end
end
