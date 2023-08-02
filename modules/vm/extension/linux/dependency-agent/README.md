Dependency Agent enables the 'Map' feature that is enabled when using the Azure Monitor Agent. In order to leverage this feature you need to set the Dependency Agent's Virtual Machine Extension settings like this:

```
settings = jsonencode({
    enableAMA = true
  })
```
