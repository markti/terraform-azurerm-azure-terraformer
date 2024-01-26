# Welcome to the Azure Terraformer Module Library

Welcome to the Azure Terraform Module Library, a specialized repository where I have curated a collection of Terraform modules designed specifically for Azure. This library is the fruit of my experiences and efforts, aimed at addressing various use cases that I have identified as crucial in my work. The primary focus of these modules is to offer pragmatic and efficient solutions to specific problems encountered in Azure infrastructure management.

## Purpose and Philosophy

The core philosophy behind this library is pragmatism. While creating these modules, my intent has been to develop solutions that are straightforward, effective, and tailored to the needs at hand. This approach means that sometimes, the solutions may prioritize expediency over other architectural aspects such as security, high availability, and extensibility. The modules are crafted with a focus on solving a particular problem in the most direct and efficient way possible.

### Module Characteristics

1. **Practicality Over Perfection**: The modules are not designed to be 'gold-plated' solutions. They are practical tools, honed to address specific needs within Azure environments. This approach allows for quick deployment and adaptability in dynamic scenarios.

2. **Targeted Solutions**: Each module is developed with a particular use case in mind. This focus ensures that the solutions are not over-engineered but instead are perfectly aligned with the requirements of the specified problem.

3. **Balance of Expediency and Quality**: While expediency is a significant factor in these modules, it does not come at the expense of quality. The modules are developed to maintain a balance, ensuring that while speed is prioritized, the basic standards of quality are not compromised.

4. **Community and Collaboration**: This library is not just a personal repository but a platform for collaboration. Users are encouraged to provide feedback, suggest improvements, and even contribute to the development of new modules. This collaborative approach aims to enrich the library and make it more robust and diverse.

### Use Cases and Applications

The modules in this library are suitable for a range of applications within Azure, from simple resource management to more complex infrastructure setups. Whether you are looking to quickly deploy a network, set up a storage solution, or manage Azure policies, there is likely a module in this library that can simplify your workflow.

### Disclaimer and Responsibility

As the developer of these modules, I emphasize that while they are crafted with care, they are not infallible. Users should exercise their judgment and due diligence when deploying these modules in their environments. It is recommended to thoroughly review and test the modules before implementing them in any production environment.

### Conclusion

The Azure Terraformer Module Library is a dynamic and evolving project, reflecting my journey in solving real-world problems in Azure with Terraform. It stands as a testament to practicality and efficiency in cloud infrastructure management. I invite you to explore these modules, utilize them in your projects, and join in the collaborative spirit to further enhance and expand this library.

## The 'Keep-It-Simple-Stupid' Modules

Welcome to my "Keep-It-Simple-Stupid" (KISS) Terraform modules, your go-to toolkit for lightning-fast lab environment setups on Azure! 🚀 Need to spin up something in a jiffy for your sandbox experiments? These modules are your new best buddies. Picture this: less fuss, more fun – and presto! You've got a lab environment humming on Azure before you can even say "Where's my coffee?" ☕

Here's the deal: these KISS modules are all about speed and simplicity. They're tailor-made for those "I need it yesterday" moments when setting up a complex, production-grade environment feels like overkill. Think of them as the quick-and-dirty, super-chill way to get your Terraform labs rolling. Just a heads up, though – these babies are for lab shenanigans only, not for your serious, buttoned-up production needs. So, grab these modules, play around, break things, learn a ton, and most importantly – keep it fun! 🌟 Remember, in the world of KISS modules, it's all about making Terraform on Azure as breezy as a walk in the park. 🌳💨

### Rando Region

I've wrapped the wonderful little Azure Regions module that Matt White and I coded up literally at the Microsoft Booth at HashiConf 2023. Matt later significantly enhanced and [published the module](https://github.com/Azure/terraform-azurerm-regions) in the official Azure organization on GitHub.

What I did was further encapsulate it to make it easier to use for an extremely common use case of just randomly selecting a single region for putting together a quick Terraform lab.

```
module "rando_region" {
  source          = "markti/azure-terraformer/azurerm//modules/region/rando"
  version         = "1.0.5"
  geography_group = "US"
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.name}-${random_string.main.result}"
  location = module.rando_region.result[0]
}
```

### Simple Network with Bastion

```
module "network" {
  source  = "markti/azure-terraformer/azurerm//modules/network/simple"
  version = "1.0.5"

  name                = random_string.main.result
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

}
```

With this module you can simply snag the default subnet ID (e.g., `module.network.subnet_id`) and keep on truckin'!

### Simple Keyvault with Terraform User Access

```
module "keyvault" {
  source  = "markti/azure-terraformer/azurerm//modules/keyvault/simple"
  version = "1.0.5"

  name                = random_string.main.result
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

}
```

With this module you can simply snag the KeyVault ID (e.g., `module.keyvault.id`) and keep on keepin' on provisioning secrets for your lab.

## Contributing


### Tagging

Get the list of versions

`git tag -l`

Create a new tag to update the version:

`git tag -a v1.0.1 -m "version notes"`

Push the tag

`git push origin --tags`