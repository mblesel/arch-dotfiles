---
description: Replace with this agent's purpose
mode: subagent # all, primary, subagent
permissions:
  # Keep this first: it denies plugin-defined actions and MCP tools until explicitly allowed below.
  - action: "*"
    resource: "*"
    effect: deny

  # Built-in permission actions (V2).
  - action: read
    resource: "*"
    effect: deny
  - action: edit # edit, write, and patch
    resource: "*"
    effect: deny
  - action: glob
    resource: "*"
    effect: deny
  - action: grep
    resource: "*"
    effect: deny
  - action: shell
    resource: "*"
    effect: deny
  - action: subagent
    resource: "*"
    effect: deny
  - action: skill
    resource: "*"
    effect: deny
  - action: question
    resource: "*"
    effect: deny
  - action: webfetch
    resource: "*"
    effect: deny
  - action: websearch
    resource: "*"
    effect: deny
  - action: external_directory
    resource: "*"
    effect: deny
  - action: execute # Code Mode; nested tools also check their own permissions
    resource: "*"
    effect: deny
  - action: browser # Removes the browser catalog when denied
    resource: "*"
    effect: deny

  # MCP tools have dynamic action names: <server>_<tool>, resource "*".
  # Add a specific allow rule after the denies when needed, for example:
  # - action: github_search_issues
  #   resource: "*"
  #   effect: allow
---

Replace with the agent's instructions.
