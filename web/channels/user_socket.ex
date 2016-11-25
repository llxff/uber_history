defmodule UberHistory.UserSocket do
  use Phoenix.Socket

  channel "history", UberHistory.HistoryChannel

  transport :websocket, Phoenix.Transports.WebSocket, timeout: 45_000
  transport :longpoll, Phoenix.Transports.LongPoll, timeout: 45_000

  def connect(%{"token" => token}, socket) do
    client = Uber.OAuth.client(token)

    case Uber.Api.me(client) do
      nil ->
        :error
      user ->
        socket = socket
          |> assign(:token, token)
          |> assign(:uuid, user["uuid"])

        {:ok, socket}
    end
  end

  def connect(_params, _socket), do: :error

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     UberHistory.Endpoint.broadcast("users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(socket), do: "users_socket:#{ socket.assigns.uuid }"
end
