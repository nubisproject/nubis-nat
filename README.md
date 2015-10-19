# nubis-nat
This builds a HA NAT instance similar to the AWS provided NAT instances

## Prerequisites
If you are new to the Nubisproject you will need to set up some [prerequisites](https://github.com/Nubisproject/nubis-docs/blob/master/PREREQUISITES.md). 

## Build the project
If you run *nubis-builder* it will output an ami id for you to use.
```bash
nubis-builder build
```

## Configure the deployment
Create a nubis/cloudformation/parameters.json file by copying the [parameters.json-dist](nubis/cloudformation/parameters.json-dist) file and editing the parameter values. More detailed instructions can be found [here](nubis/cloudformation/README.md#set-up).
```bash
cp nubis/cloudformation/parameters.json-dist nubis/cloudformation/parameters.json
vi nubis/cloudformation/parameters.json
```

## Deploy the stack
You are now ready to deploy your stack. Be sure to replace "YOUR_NAME" with a unique stack name. You can find more detailed instructions [here](nubis/cloudformation/README.md#commands-to-work-with-cloudformation).
```bash
aws cloudformation create-stack --template-body file://nubis/cloudformation/main.json --parameters file://nubis/cloudformation/parameters.json --stack-name YOUR-STACK
```

## Help
If you run into any issues, feel free to reach out to us. We hang out in #nubis-users on irc.mozilla.org.
