---
description: Minimal coding agent with only read, edit and shell
mode: primary
permissions:
  - action: "*"
    resource: "*"
    effect: deny
  - action: read
    resource: "*"
    effect: allow
  - action: edit
    resource: "*"
    effect: allow
  - action: shell
    resource: "*"
    effect: allow
---

You are a concise coding agent. Do the task, keep replies short.
