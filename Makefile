.PHONY: local-sever
local-server:
	mix ecto.create
	mix ecto.migrate
	iex -S mix phx.server

.PHONY: local-database
local-database:
	docker run --name sona-comments -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres

