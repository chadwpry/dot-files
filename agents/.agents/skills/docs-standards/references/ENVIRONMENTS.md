# [Project Name] — Environments

> **Last updated:** [DATE]
> **Audience:** Developers configuring, running, or debugging the system

This document covers **operational concerns**: how to get the system running, what credentials you need, how to configure your environment, and how to troubleshoot. For design decisions and rationale, see [ARCHITECTURE.md](ARCHITECTURE.md).

---

## Quick Start

[Command to run the interactive setup script, if one exists]
[Common day-to-day commands for starting services, running tests, etc.]

---

## Where Things Run

[Concise description of the hybrid architecture: what runs locally, what runs in the cloud, and why]

**Local services** (started by [command]):

| Port | Service | Purpose |
|------|---------|---------|
| [port] | [service] | [what it does] |

**Cloud services** (require API keys — cannot be self-hosted for the prototype):

| Service | What it provides | Free tier |
|---------|-------------------|-----------|
| [service] | [one-line description] | [free tier info] |

> For the rationale behind each provider choice, see [ARCHITECTURE.md](ARCHITECTURE.md).

---

## Cloud Accounts & API Keys

You need accounts on the cloud services listed above. Each section below links to the signup page and notes what you need.

### [Service Name]

**Create project at:** [URL]

- [Required region / configuration]
- [What credentials to note down]
- [Any special setup steps]

[Repeat for each cloud service]

### [Optional Service Name] (optional)

[Same format, but marked optional with note about what degrades without it]

---

## Local [Primary Backend Service] Configuration

[Configuration details for the local backend service — e.g., Supabase, Firebase, etc.]

Key local settings:

| Setting | Value | Notes |
|---------|-------|-------|
| [config key] | [value] | [why] |

**Local development quirks:**
- [Quirk 1 — e.g., "Emails are not sent locally. Check Studio at http://localhost:X instead."]
- [Quirk 2 — e.g., "OAuth providers require cloud project configuration."]

---

## Environment Variables Reference

### [Frontend] (`[path/to/.env.example]`)

| Variable | Required | Example | Notes |
|----------|----------|---------|-------|
| `[VAR_NAME]` | Yes/No | `[example]` | [What it's for, any prefix requirements] |

[Repeat for each target: frontend, agent, server-side secrets]

### Environment Variable Management

| Environment | Frontend | [Backend Functions] | [Agent/Worker] |
|-------------|----------|---------------------|----------------|
| **Local dev** | [how loaded] | [how loaded] | [how loaded] |
| **Production** | [where set] | [where set] | [where set] |
| **Rule** | [prefix rules, gitignore rules] | [access pattern] | [access pattern] |

> **Never commit `.env.local` or `.env` files to git.** Both are in `.gitignore`.

---

## Testing the Full Flow

[Step-by-step instructions to verify the system works end-to-end]

1. [Start service A]
2. [Navigate to URL]
3. [Perform action]
4. [Verify expected result]

### Testing Without [Optional Component]

[How to test with partial services — e.g., "skip the voice agent, manually insert data"]

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| [Common error 1] | [Fix] |
| [Common error 2] | [Fix] |
| [Common error 3] | [Fix] |

---

## Reset Instructions

**Reset the database:**
```bash
[command]
```

**Stop all local services:**
```bash
[command]
```

**Full reset** (removes volumes too):
```bash
[commands]
```

**Reinstall dependencies:**
```bash
[commands per package manager]
```

---

## Production Deployment

| Component | Target | Notes |
|-----------|--------|-------|
| [Frontend] | [Platform] | [Notes] |
| [Agent/Worker] | [Platform] | [Notes] |
| [Backend] | [Platform] | [Notes] |

Production deployment steps:
1. [Step 1]
2. [Step 2]
3. [Step 3]

---

*[End of ENVIRONMENTS.md]*