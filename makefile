up:
	mix deps.get
init:
	docker-compose up -d
	mix ecto.migrate
test:
	MIX_ENV=test mix ecto.create
	MIX_ENV=test mix ecto.migrate
	mix test
run: 
	mix phx.server