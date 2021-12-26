####################################################
# DEFINE YOUR TEAM AND ASSIGN MEMBERS HERE
###################################################
team_membership = {
  team_1 = [
    # "user-a",
    # "user-b"
  ],
  team_2 = [
    # "user-c",
    # "user-d",
    # "user-e"
  ],
  team_4 = [
    # "user-1",
    # "user-2",
    # "user-3"
  ]
}

##############################################################################
# DEFINE YOUR REPOSITORY AND TEAMS THAT SHARE ADMINISTRATION PERMISSION HERE
#############################################################################
repo_declaration = {
  disney-service = {
    description                 = ""
    template_name               = "some_template",
    teams_with_admin_permission = ["team_4"],
  },
  card-repo = {
    description                 = ""
    template_name               = "some_template",
    teams_with_admin_permission = [],
  },
  test-service = {
    description                 = ""
    template_name               = "",
    teams_with_admin_permission = ["team_1", "team_2"],
  }
  payment-proxy-management-service = {
    description                 = ""
    template_name               = "some_template",
    teams_with_admin_permission = [],
  }
  marvel_repo = {
    description                 = ""
    template_name               = "",
    teams_with_admin_permission = [],
  }
}
