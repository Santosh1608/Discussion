import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :talk, Talk.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "talk_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :talk, TalkWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Vph5rr1Oi4qTDub6yTs33DeNKu4gkCKvUEL6iD27Msr3B8eYaGAF7ZhRbV0Fj16I",
  server: false

# In test we don't send emails.
config :talk, Talk.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
