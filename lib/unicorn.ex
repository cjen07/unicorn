defmodule Unicorn.TedList do
  use Ecto.Schema

  schema "ted_list" do
    field :title
    field :link
  end
end

defmodule Unicorn do
  import Meeseeks.CSS
  import Meeseeks.Result
  import Ecto.Query

  alias Unicorn.Repo
  alias Unicorn.TedList

  @host "https://www.ted.com"

  def run() do
    list(1)
  end

  def list(n) do
    l = page(n)
    b = HTTPoison.get!(l).body
    c = Meeseeks.all(b, css("#browse-results div.talk-link div.media__message a.ga-link"))
    case c do
      [] -> :ok
      _ -> 
        Enum.each(c, fn x -> Repo.insert! %TedList{title: text(x), link: attr(x, "href")} end)
        list(n + 1)
    end
  end

  def page(n) do
    @host <> "/talks?page=#{n}&sort=newest"
  end

  def media(n \\ 64) do
    Unicorn.TedList
    |> where([i], i.status == false)
    |> select([i], i)
    |> Repo.all
    |> (fn x -> 
      m = div(length(x), n) + 1
      Enum.chunk(x, m, m, []) 
    end).()
    |> Enum.each(fn x -> 
      Task.async(fn ->
        Enum.each(x, fn x ->
          {t, l} = {x.title, x.link}
          download(t, l)
          audio(t)
          Ecto.Changeset.change(x, %{status: true})
          |> Repo.update!()
        end)
      end)
    end)

  end

  def download(t, l) do
    System.cmd("youtube-dl", [@host <> l, "--ouput", t <> ".mp4"], cd: "video")
  end

  def audio(t) do
    System.cmd("ffmpeg", ["-i", @proxy, t <> ".mp4", "../audio/" <> t <> ".mp3"], cd: "video")
  end
end
