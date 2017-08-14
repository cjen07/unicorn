# Unicorn

Get TED video and audio, just for learning

## prerequisite

* erlang 20.0
* elixir 1.5.1
* rust 1.19.0
* postgresql 9.5.7
* youtube-dl 2017.08.13
* ffmpeg 2.8.11


## usage

* set your path in config.exs and create audio and video folder in it
* `mix deps.get`
* `mix ecto.create && mix ecto.migrate`
* `nohup mix run -e Unicorn.list --no-halt &`
* `nohup mix run -e Unicorn.media --no-halt &`