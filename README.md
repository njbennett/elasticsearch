# Deploy BOSH and Elasticsearch
This is an example of a BOSH deployment, 
complete with infrastructure paving.
It has only been hand-tested
and has not been updated
since August 19, 2018.

(If you're reading this in a text editor
that preserves linebreaks,
you'll see that it's formatted
to be displayed in a Markdown viewer.
Using one-ish line per phrase makes it easier
to manage text with git,
and to pair on writing documentation,
so I use this style pretty much everywhere.)

## Summary
The `do-the-thing.sh` script
should deploy a BOSH director to an AWS account
and then deploy a single-node Elasticsearch.
It uses a community-provided BOSH release
which I haven't personally tested or validated.

BBL will create a bunch of files
recording the results of the terraform command it ran
variables it generated
and the state of the BOSH director it deployed.
They contain credentials
which give you full access to an AWS account.
If you want to keep using this director,
you'll need to store these files somewhere safe.

## Instructions
To run the `do-the-thing.sh` script
you'll need to install BOSH and BOSH Boot Loader,
terraform, an AWS account, and the aws cli.

When testing, I installed these depenencies with homebrew.

```
brew install bosh-cli
brew install bbl
brew install aws-cli
```
(I recommend managing your workstation setup
with a brewfile and an install.sh script
for any non-brew-based configuration,
but I've been procrastinating 
getting the workstation I used for this
set up properly.)

The script was tested with
`bosh version 4.0.1-a18c7230-2018-05-23T23:11:20Z`
and `bbl version 6.6.4 (darwin/amd64)`

You'll also need an AWS account
and to have logged in locally to the aws cli.
When testing, I used credentials from the admin user
with the [aws configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

# Teardown
Run `bosh delete-deployment -d elasticsearch -n` to delete the BOSH Deployment.

Run `bbl destroy` with the IAM user credentials 
to delete the BOSH Director and Jumpbox.

Then delete the `bbl-user` in the AWS console.
(There's definitely a way to do this on the command line
but currently AWS complains about having to delete policies first
so I just gave in to the GUI.)

# Additional Documentation
This repository is based on the [BOSH Boot Loader getting started documentation]().
If `do-the-thing.sh` doesn't work
try comparing it to the commands listed in that BBL documentation.
