# case 1: Complex Types
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

# case 1: Complex Types with defaults 
module "c2" {
  source      = "./modules/case2"  
  my_settings = {
    string1   = "hello world"
  }
}

output "c2_1" {
  value = module.c2.out2
}


#######################################

# case 3: 
module "c3" {
  source      = "./modules/case3"  
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
  value = module.c3.out2
}
