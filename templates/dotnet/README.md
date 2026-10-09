# .NET starter

This example targets .NET 10 and includes a minimal ASP.NET Core health endpoint, xUnit test, and multi-stage non-root container. The shared workflow restores the solution, verifies formatting, and runs tests; the template also calls the shared dependency review workflow.

Copy this directory into a new service repository and replace the reusable workflow owner/version. For production, add the organization's approved NuGet lockfile/restore mode, SAST, secret scanning, dependency/license policy, and container scanning. Review the .NET support lifecycle and container base images.
