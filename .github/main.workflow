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
  secrets = ["HEROKU_API_KEY"]
}

action "release" {
  uses = "actions/heroku@master"
  needs = "push"
  args = "container:release -a bookstore-pedrolacerda web"
  env = {
    HEROKU_APP = "bookstore-pedrolacerda"
  }
  secrets = ["HEROKU_API_KEY"]
}

workflow "Update boards with issues" {
  on = "issues"
  resolves = ["Create Azure Boards Work Item"]
}

action "Create Azure Boards Work Item" {
  uses = "azure/github-actions/boards@master"
  env = {
    AZURE_DEVOPS_URL = "https://dev.azure.com/pedrohrl1" #ADO URL
    AZURE_DEVOPS_PROJECT = "Reading Time Demo"                       #ADO Project
    AZURE_BOARDS_TYPE = "Task"                            #Board Type...this is from the ADO [proccess doc](https://docs.microsoft.com/en-us/azure/devops/boards/work-items/guidance/choose-process?view=azure-devops)
  }
  secrets = ["AZURE_DEVOPS_TOKEN"]

  #ADO Token from your security settings
}

workflow "Deploy using Terraform" {
  resolves = ["Deploy AWS"]
  on = "push"
}

action "Deploy AWS"{
  
}
