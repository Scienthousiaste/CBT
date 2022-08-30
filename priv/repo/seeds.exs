# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cbt.Repo.insert!(%Cbt.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

default_user = Cbt.Repo.insert!(%Cbt.Accounts.Experimenter{
  email: "test_experimenter@mail.com",
  firstname: "test",
  lastname: "test",
  is_admin: false
})

default_task = Cbt.Repo.insert!(%Cbt.Experiment.Task{
  name: "Default CBT"
})

#TODO: return a list of default questions to seed here
