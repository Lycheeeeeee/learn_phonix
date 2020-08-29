# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BusiApi.Repo.insert!(%BusiApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias BusiApi.Repo
alias BusiApi.Directory.User
Repo.insert!(%User{firstname: "Sam", lastname: "H", gmail: "HSam@gmail.com"})
Repo.insert!(%User{firstname: "Jame", lastname: "Milner", gmail: "MJame@gmail.com"})
Repo.insert!(%User{firstname: "Luka", lastname: "Ku", gmail: "KLuka@gmail.com"})
