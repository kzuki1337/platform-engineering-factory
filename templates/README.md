# Application starters

These examples show the expected consumer contract: keep the application build definition and tests in the application repository, call a centrally versioned workflow, and publish an immutable image only from a protected branch. The Python starter is the primary end-to-end example; Node.js and .NET demonstrate the same shared-workflow contract. Replace `YOUR-ORG/platform-cicd` and the example version with the actual framework repository/release. For production, follow the action SHA pinning policy.

| Runtime | Starter | Central workflow |
|---|---|---|
| JavaScript / Node.js | [`node/`](node/) | `node-ci.yml` |
| Python | [`python/`](python/) | `python-ci.yml` |
| .NET | [`dotnet/`](dotnet/) | `dotnet-ci.yml` |

Copy a starter into an application repository; do not make application repositories depend on this framework repository's mutable working tree. Review base-image versions and dependency pins regularly.
