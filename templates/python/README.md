# Python service starter

This is the primary application example for the platform framework: a small, installable Python 3.12 HTTP service with health checks, tests, a non-root container, and a typed workflow call to the shared CI workflow.

```sh
python -m venv .venv
. .venv/bin/activate
python -m pip install --editable ".[dev]"
ruff check src tests
pytest --strict-markers --strict-config
python -m platform_app
```

The service uses only the Python standard library at runtime. Development tools are pinned in `pyproject.toml`; add production dependencies there and use the organization's approved lockfile/dependency review process. The shared workflow runs lint and tests on pull requests and the protected branch.

Copy this directory into an application repository, replace the reusable workflow owner/version, and add application-specific checks. Add organization-approved SAST, secret scanning, dependency/license analysis, and container scanning. Review Python and base-image support cadence before production.
