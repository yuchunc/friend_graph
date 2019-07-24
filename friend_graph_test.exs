Code.load_file("friend_graph.exs", __DIR__)

ExUnit.start()

defmodule FriendGraphTest do
  use ExUnit.Case

  describe "shortest_path/1" do
    setup do
      user_nodes = [
        %{id: 1, friends: [2, 3, 4]},
        %{id: 2, friends: [1, 3, 5]},
        %{id: 3, friends: [1, 2]},
        %{id: 4, friends: [1]},
        %{id: 5, friends: [2]}
      ]

      {:ok, nodes: user_nodes}
    end

    test "return 0 if starting and end nodes are the same", ctx do
      %{nodes: nodes} = ctx

      assert FriendGraph.shortest_distance(nodes, 1, 1) == 0
    end

    test "returns 0 if node list is empty" do
      assert FriendGraph.shortest_distance([], 1, 1) == 0
    end

    test "return :not_found if end node cannot be found", ctx do
      %{nodes: nodes} = ctx

      broken_nodes =
        nodes |> Enum.reject(&(&1.id == 2)) |> Enum.concat([%{id: 2, friends: [1, 3]}])

      assert FriendGraph.shortest_distance(broken_nodes, 1, 5) == :not_found
    end

    test "return 1 if immediate neighbour", ctx do
      %{nodes: nodes} = ctx

      assert FriendGraph.shortest_distance(nodes, 1, 3) == 1
    end

    test "finds the shortest path between user 1 and 5", ctx do
      %{nodes: nodes} = ctx

      assert FriendGraph.shortest_distance(nodes, 1, 5) == 2
    end
  end
end
