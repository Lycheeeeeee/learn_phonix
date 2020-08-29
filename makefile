up:
	mix get.deps
init:
	mix ecto.migrate
test:
	MIX_ENV=test mix ecto.create
	MIX_ENV=test mix ecto.migrate
	mix test
run: 
	mix phx.server