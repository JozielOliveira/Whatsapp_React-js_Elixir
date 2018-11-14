defmodule Api.MsgView do
  use Api.Web, :view

  def render("index.json", %{msg: msg}) do
    %{data: render_many(msg, Api.MsgView, "msg.json")}
  end

  def render("show.json", %{msg: msg}) do
    %{data: render_one(msg, Api.MsgView, "msg.json")}
  end

  def render("msg.json", %{msg: msg}) do
    %{id: msg.id,
      author: msg.author,
      description: msg.description}
  end
end
