workflow "Deploy on Heroku" {
  resolves = ["release"]
  on = "push"
}

action "login" {
  uses = "actions/heroku@master"
  args = "container:login"
  secrets = ["HEROKU_API_KEY"]
}

action "push" {
  uses = "actions/heroku@master"
  needs = "login"
  args = "container:push -a bookstore-pedrolacerda web"
  env = {
    HEROKU_APP = "bookstore-pedrolacerda"
  }
}

action "release" {
  uses = "actions/heroku@master"
  needs = "push"
  args = "container:release -a bookstore-pedrolacerda web"
  env = {
    HEROKU_APP = "bookstore-pedrolacerda"
  }
}
