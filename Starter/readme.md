# Terraform Time

This repo has three sessions which build on top of knowledge from the sessions before. Each session is made of up small interactive tasks so that people can get hands on with Terraform. Each session contains:

- Readme.md
  - Describes the individual tasks providing helpful commands and links
- Facilitator_notes.md
  - Useful notes for the facilitator running the session
- `./src`
  - This contains solutions to each of the indvidual tasks.
  - The recommended approach is that people only refer to these solutions if they need to, instead try and write the HCL itself, don't copy and paste

## Session1

This session is based around getting started with Terraform and HCL, it does not create any cloud resources, instead focusing on creating/destroying/renaming files locally so that people get used to the "flow" of Terraform and the ideas behind it.

## Session2

This session gets people creating things in Azure. It is focused around connecting and ensuring you are deploying to the correct subscription, creating some basic resources and then working up to creating a VM.

## Session3

This session adds in more Terraform concepts, modules and state. It is focused around creating resources in Azure but using modules to make them repeatable and state so that others can work on them.
