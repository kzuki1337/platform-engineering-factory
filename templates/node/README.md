# Node.js starter

The starter uses Node's built-in HTTP server and test runner to keep the template dependency-free. The central workflow expects `package-lock.json` and runs `npm ci`, lint, tests, build, and `npm audit`. Add organization-approved SAST, secret scanning, license review, and container scanning as required by policy.

Copy this directory into a new service repository, replace the reusable workflow owner/version, add application-specific tests, and review the base image and Node release cadence.
