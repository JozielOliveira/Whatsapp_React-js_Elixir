defmodule Api.MsgController do
  use Api.Web, :controller

  alias Api.Msg

  def index(conn, _params) do
    msg = Repo.all(Msg)
    render(conn, "index.json", msg: msg)
  end

  def create(conn, %{"msg" => msg_params}) do
    changeset = Msg.changeset(%Msg{}, msg_params)

    case Repo.insert(changeset) do
      {:ok, msg} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", msg_path(conn, :show, msg))
        |> render("show.json", msg: msg)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Api.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    msg = Repo.get!(Msg, id)
    render(conn, "show.json", msg: msg)
  end

  def update(conn, %{"id" => id, "msg" => msg_params}) do
    msg = Repo.get!(Msg, id)
    changeset = Msg.changeset(msg, msg_params)

    case Repo.update(changeset) do
      {:ok, msg} ->
        render(conn, "show.json", msg: msg)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Api.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    msg = Repo.get!(Msg, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(msg)

    send_resp(conn, :no_content, "")
  end
end
