defmodule TalkWeb.TopicController do
  use TalkWeb, :controller

  alias Talk.Posts.Topic
  alias Talk.Posts

  plug(:is_authorized when action in [:update, :delete])


  def index(conn, _params) do
    topics = Posts.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    if(!conn.assigns.user) do
      conn
      |> put_flash(:error, "please sign in first")
      |> redirect(to: "/")
    end

    case Posts.create_topic(topic,conn.assigns.user) do
      {:ok, _topic} -> redirect(conn, to: "/")
      {:error, changeset} -> render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn,_params) do
    
    Posts.delete_topic(conn.assigns.topic)

    redirect(conn, to: "/")
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Posts.get_topic!(topic_id)
    render conn, "edit.html", changeset: Topic.changeset(topic), topic: topic
  end

  def update(conn, %{"topic" => topic}) do
    
    Posts.update_topic(conn.assigns.topic,topic)

    redirect(conn, to: "/")
  end

  def show(conn, %{"id" => topic_id}) do
    topic  = Posts.get_topic!(topic_id)
    render conn, "show.html", topic: topic
  end

  defp is_authorized(conn,_params) do
    %{params: %{"id" => topic_id}} = conn
    topic = Posts.get_topic!(topic_id)

    if topic.user_id == conn.assigns.user.id do
      assign(conn,:topic,topic)
    else
      conn
      |> put_flash(:error,"Not your topic")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end
