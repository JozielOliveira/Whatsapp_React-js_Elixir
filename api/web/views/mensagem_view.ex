defmodule Api.MensagemView do
  use Api.Web, :view

  def render("index.json", %{mensagem: mensagem}) do
    %{data: render_many(mensagem, Api.MensagemView, "mensagem.json")}
  end

  def render("show.json", %{mensagem: mensagem}) do
    %{data: render_one(mensagem, Api.MensagemView, "mensagem.json")}
  end

  def render("mensagem.json", %{mensagem: mensagem}) do
    %{id: mensagem.id,
      author: mensagem.author,
      description: mensagem.description}
  end
end
