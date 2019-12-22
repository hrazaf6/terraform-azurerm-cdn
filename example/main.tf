module "azure_cdn" {
    source      = "../"
    resource_group_name = "test-rg" #Please change this with the resource group you want the resource get deployed
    name = "test" #Name of the CDn and Endpoint depend on this
    tier = "standard" #As of now, cdn profile support only standard and preminum 
    cdn_provider = "microsoft" # 
    enable_endpoint = false #Change to true if you want to have the endpoints
    origin_hostnames = [""] #Provide the hostnames which will be behind the endpoint
    tags = {
        "Environment" = "Dev"
    }
}