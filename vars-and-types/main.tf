

#######################################

# case1: complex type as variable
module "c1" {
  source      = "./modules/case1"
  my_settings = {
    string1   = "hello world"
    number1   = 1000
    bool1     = true
  }
}

output "c1_1" {
  value = module.c1.out2
}

#######################################

# case2: complex type as variable with default and optional attributes
module "c2" {
  source      = "./modules/case2"
  my_settings = {
    string1   = "hello world"
  }
}

output "c2_1" {
  value = module.c2.out1
}


#######################################

# case3: complex type map with functions
module "c3" {
  source      = "./modules/case3"
  DefaultConnection = "con1"
  ServiceConnections  = {
      "con1" = {
        Prefix    = "prefix 1"
        Postfix   = "postfix 1"
      }
      "con2" = {
        Prefix    = "prefix 2"
        Postfix   = "postfix 2"
      }
  }

}

output "c3_1" {
  value = module.c3.out1
}

output "c3_2" {
  value = module.c3.out2
}

output "c3_3" {
  value = module.c3.out3
}

output "c3_4" {
  value = module.c3.out4
}

output "c3_5" {
  value = module.c3.out5
}



#######################################

# case4: complex type map with foreach
module "c4" {
  source      = "./modules/case4"
  ServiceConnections  = {
      "con1" = {
        Prefix    = "prefix 1"
        Postfix   = "postfix 1"
      }
      "con2" = {
        Prefix    = "prefix 2"
        Postfix   = "postfix 2"
      }
  }

}

output "c4_1" {
  value = module.c4.out1
}

output "c4_2" {
  value = module.c4.out2
}

output "c4_3" {
  value = module.c4.out3
}

output "c4_4" {
  value = module.c4.out4
}


#######################################

# case5: all together complex type with default and map as attribute and foreach
module "c5" {
  source      = "./modules/case5"
   my_settings = {
    string1             = "hello world"
    DefaultConnection   = "con2"
    ServiceConnections  = {
      "con1" = {
        Prefix    = "prefix 1"
        Postfix   = "postfix 1"
      }
      "con2" = {
        Prefix    = "prefix 2"
        Postfix   = "postfix 2"
      }
    }
  }
}

output "c5_1" {
  value = module.c5.out1
}

output "c5_2" {
  value = module.c5.out2
}

output "c5_3" {
  value = module.c5.out3
}

output "c5_4" {
  value = module.c5.out4
}

output "c5_5" {
  value = module.c5.out5
}

# output "c5_6" {
#   value = module.c5.out6
# }

# output "c5_7" {
#   value = module.c5.out7
# }

output "c5_X" {
  value = module.c5.out3["con1"]
}


############################

variable "c0_vars" {
     type      = set(string)
     default = [
          "k1",
          "k2",
          "k3"
     ]
}

module "c0" {
  source      = "./modules/case0"
  for_each    = var.c0_vars
  var1        = each.value
}

output "c0_1" {
  value = module.c0["k1"].out1
}
