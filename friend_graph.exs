defmodule FriendGraph do
  def shortest_distance(_, start_id, start_id), do: 0
  def shortest_distance([], _, _), do: 0

  def shortest_distance(nodes, start_id, end_id) do
    traverse(nodes, [{start_id, 0}], [], end_id)
  end

  defp traverse(_, [], _, _), do: :not_found

  defp traverse(nodes, [{node_id, dist} | queue], visited, end_id) do
    node = Enum.find(nodes, &(&1.id == node_id))

    if end_id in node.friends do
      dist + 1
    else
      id_dist =
        (node.friends -- visited)
        |> Enum.map(&{&1, dist + 1})

      traverse(nodes, queue ++ id_dist, [node_id | visited], end_id)
    end
  end
end
