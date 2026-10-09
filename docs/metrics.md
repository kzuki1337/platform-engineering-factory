# Pipeline metrics and dashboard

Measure adoption and outcomes, not just run counts. Use workflow/job events and deployment records as the source of truth. Add a stable service identifier, owning team, environment, framework version, source commit, artifact digest, and deployment outcome to event metadata. Never emit secrets, source snippets, or sensitive environment values.

## Recommended metrics

| Area | Metric | Useful dimensions |
|---|---|---|
| Adoption | Repositories/services using supported workflows; workflow version distribution | Team, runtime, repository, framework version |
| Usage | Runs, jobs, reruns, cancellation rate | Workflow, trigger, branch class, team |
| Feedback | Queue, job, PR-to-check, and end-to-end workflow duration (median and p90) | Runner class, workflow, runtime |
| Reliability | Success/failure rate, flaky test rate, failure reason, retry rate | Workflow/job, repository, runner |
| Delivery | Commit-to-production lead time, deployment frequency, rollback/change-failure rate | Service, environment, team |
| Security | Findings by severity/age, time to remediate, exceptions and expirations, artifact provenance coverage | Tool/category, repo, team |
| Cost/capacity | Runner minutes and cost allocation, idle capacity, queue time, utilization | Runner group, account, team |
| Operations | Deploy success, health-check outcome, rollback duration, environment availability | Service, cluster, environment |

## Dashboard views

1. **Platform health:** workflow availability, run outcomes, queue p50/p90, runner capacity, and alerting.
2. **Adoption:** eligible and onboarded repos, supported-version coverage, runtime/team breakdown.
3. **Delivery effectiveness:** lead time, deployment frequency, change failure/rollback, and environment promotion duration.
4. **Security posture:** open findings by age/severity, overdue remediation, expired exceptions, image scan/signature coverage.
5. **Cost and efficiency:** minutes/cost by runner group and team, utilization, queue hotspots, reruns.

## Data and governance

- Emit structured workflow telemetry and deployment events with a stable correlation ID from commit to artifact to release.
- Retain raw events only as long as operational and compliance needs require; aggregate for longer-term trends.
- Use a central event sink/dashboard already supported by the organization (for example CloudWatch or its existing observability platform). Decide before implementing an exporter to avoid creating a second telemetry stack.
- Enforce metric label cardinality limits: avoid raw branch names, user names, commit hashes, or arbitrary exception text as metric labels. Store detailed audit records separately with access control.
- Set SLOs only after a baseline period. Agree on alert owners and actionable thresholds; dashboard-only metrics without an accountable owner are not an operational control.

## Initial scorecard

Start with weekly workflow adoption, success rate, median/p90 queue and check duration, deploy frequency, lead time, change failure/rollback, and runner cost/utilization. Add security aging and exception expiry from day one. Review with application and platform teams monthly and publish methodology so teams understand the measures.
