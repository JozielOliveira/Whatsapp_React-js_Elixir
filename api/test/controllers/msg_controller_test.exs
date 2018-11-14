defmodule Api.MsgControllerTest do
  use Api.ConnCase

  alias Api.Msg
  @valid_attrs %{author: "some author", description: "some description"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, msg_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    msg = Repo.insert! %Msg{}
    conn = get conn, msg_path(conn, :show, msg)
    assert json_response(conn, 200)["data"] == %{"id" => msg.id,
      "author" => msg.author,
      "description" => msg.description}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, msg_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, msg_path(conn, :create), msg: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Msg, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, msg_path(conn, :create), msg: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    msg = Repo.insert! %Msg{}
    conn = put conn, msg_path(conn, :update, msg), msg: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Msg, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    msg = Repo.insert! %Msg{}
    conn = put conn, msg_path(conn, :update, msg), msg: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    msg = Repo.insert! %Msg{}
    conn = delete conn, msg_path(conn, :delete, msg)
    assert response(conn, 204)
    refute Repo.get(Msg, msg.id)
  end
end
