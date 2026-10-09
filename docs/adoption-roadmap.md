# Adoption roadmap

Deliver the framework in increments. Each phase should have an owner, acceptance criteria, and a small pilot before broad rollout.

## Phase 0 — Align and set guardrails

- Confirm the open decisions in [architecture.md](./architecture.md).
- Establish framework repository ownership, `CODEOWNERS`, protected branches/rulesets, release permissions, and semantic-version policy.
- Define AWS account/network boundaries, Terraform state backend, approved regions, naming/tagging, and log retention.
- Agree on minimum quality/security gates, exception approval, and remediation SLAs.
- Choose ECR-only or the Artifactory/ECR split; identify package formats and system-of-record by format.

**Exit:** reviewed architecture, named owners, and an approved pilot scope.

## Phase 1 — Secure framework foundation

- Implement and test OIDC trust roles, ECR settings, Terraform state access, and runner isolation.
- Publish reusable pull-request CI, dependency review, Terraform validation, container build/scan, and deployment workflows.
- Validate that fork pull requests cannot obtain cloud credentials or write permissions.
- Set up workflow event collection and baseline dashboard.

**Exit:** pilot can run checks and publish a non-production artifact without long-lived credentials.

## Phase 2 — Pilot application onboarding

- Onboard one low-risk service for each required runtime where available: JavaScript/TypeScript, Python, and .NET.
- Adopt the shared workflow through a pinned framework version; keep local build/test conventions explicit.
- Deploy one image digest through dev and qa to a non-production EKS cluster using Helm.
- Test rollback, failure notifications, environment approvals, and artifact provenance.

**Exit:** teams can onboard using documentation and starter templates without bespoke privileged workflow code.

## Phase 3 — Production readiness

- Exercise uat/stg/prod protection rules, scoped IAM, change evidence, rollback, and disaster recovery.
- Verify runner patching, capacity limits, private networking, audit logs, and break-glass access.
- Tune scanner thresholds based on pilot findings; time-box exceptions with accountable owners.
- Validate metrics against workflow/deployment records and agreed SLOs.

**Exit:** security, platform, operations, and application owners sign off on production controls.

## Phase 4 — Scale and improve

- Publish a supported framework release channel and automate consumer update notices/PRs.
- Track adoption and lead-time/reliability trends; target the largest friction points.
- Add more language templates, policy-as-code, preview environments, progressive delivery, or multi-region patterns only when demand warrants.
- Deprecate old workflow versions on a published schedule and measure migration completion.

## Suggested rollout measures

- Pilot adoption: three representative services or agreed equivalents.
- Reusable workflow coverage: share of eligible repositories on supported releases.
- Security: no long-lived AWS credentials; protected production environment; no critical unaccepted findings.
- Reliability: successful promotion/rollback drills and deployment audit trail.
- Developer experience: onboarding time and median PR feedback duration.
- Operations: runner queue time/cost and service ownership for the dashboard.

Set numeric SLO targets after collecting a baseline rather than choosing arbitrary thresholds.
