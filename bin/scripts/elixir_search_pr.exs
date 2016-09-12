# Thx to https://sunaku.github.io/elixir-parallel-grep.html
defmodule Search do
  def launch(regex, files) do
    files |> Stream.reject(&File.dir?/1) |> Enum.map(fn file ->
      spawn(__MODULE__, :search, [regex, file, self])
    end)
  end

  def search(regex, file, receiver) do
    file |> File.stream! |> Enum.each(fn line ->
      case Regex.run(regex, line) do
        nil -> ; # line didn't match so ignore it
        matches -> send receiver, {file, matches}
      end
    end)
  end

  def results(count\\0) do
    receive do
      _result -> results(count+1) # consume the message and loop again
      after 1000 -> IO.puts "got #{count} results; no more in last 1s"
    end
  end
end

[pattern|files] = System.argv
regex = Regex.compile!(pattern)
Search.launch(regex, files)
Search.results
