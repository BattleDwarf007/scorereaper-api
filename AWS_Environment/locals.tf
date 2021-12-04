locals {
  images = {
    linux   = "ami-03590d67411bbd24e"
    db      = "ami-0794e365b3bb85dec"
  }
  production_availability_zones = {
    az1 = "af-south-1a"
    az2 = "af-south-1b"
    az3 = "af-south-1c"
  }

  db_subnet_ids = {
    az1 = "subnet-0effb4687ec740269"
    az2 = "subnet-082dee73b73121e7d"
    az3 = "subnet-03a910b1127a373f4"
  }

    private_subnet_ids = {
    az1 = "subnet-05125e460bd3b1560"
    az2 = "subnet-0a26219736f442f54"
    az3 = "subnet-087afb9067991eb72"
  }

    public_subnet_ids = {
    az1 = "subnet-09c18e0e9c8b70786"
    az2 = "subnet-0fb6acf0bca289eff"
    az3 = "subnet-0e60acd404bf19be7"
  }

}
