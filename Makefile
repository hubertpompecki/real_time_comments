.PHONY: local-sever
local-server: local-database
	mix deps.get
	mix ecto.create
	mix ecto.migrate
	iex -S mix phx.server

.PHONY: local-database
local-database:
	docker run --name sona-comments -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres

.PHONY: local-seeds
local-seeds:
	mix run priv/repo/seeds.exs
