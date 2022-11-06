defmodule TalkWeb.CommentsChannel do
  use TalkWeb, :channel
  alias Talk.Posts
  alias Talk.Repo

  @impl true
  def join("comments:" <> topic_id, payload, socket) do
    if authorized?(payload) do
      topic = Posts.get_topic!(topic_id) |> Repo.preload(comments: [:user])
      {:ok,%{comments: topic.comments}, assign(socket, :topic, topic)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("add", %{"comment" => content} , socket) do
    case Posts.create_comment(%{content: content},socket.assigns.topic,socket.assigns.user) do
      {:ok, comment} -> 
                        comment = Repo.preload(comment,:user)
                        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
                        {:reply, :ok, socket}
      {:error, changeset} -> {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (comments:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
