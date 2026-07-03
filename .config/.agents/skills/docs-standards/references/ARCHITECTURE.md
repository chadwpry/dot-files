# [Project Name] — Technical Architecture

> **Version:** 1.0  
> **Last updated:** [DATE]  
> **Status:** [Draft / In Review / Approved]  
> **Current scope:** [Must match PRD.md current scope]

---

## 1. System Overview

[High-level description: what services exist, what they do, how they connect]

```
[Architecture diagram — service boxes with arrows showing data flow]
```

---

## 2. Data Flow

### [Flow Name: e.g., "User Signup to Onboarding"]

```
Step 1 → Step 2 → Step 3
   │
   ▼
Step 4
```

[Describe each step. Show error paths and fallbacks.]

### [Flow Name: e.g., "Call Completion Notification"]

```
[Another data flow diagram]
```

---

## 3. Database Schema

### [Table Group: e.g., "User Data"]

#### `table_name`

```sql
CREATE TABLE table_name (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  -- columns with types, constraints, defaults
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_table_name_column ON table_name(column);

-- RLS
ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Policy name" ON table_name FOR SELECT USING (condition);
```

[Repeat for each table]

---

## 4. Project Structure

```
project-name/
├── [directory]/                    # [Purpose]
│   ├── [file]                      # [What it does]
│   └── [file]                      # [What it does]
└── [directory]/                    # [Purpose]
    ├── [file]                      # [What it does]
    └── [file]                      # [What it does]
```

---

## 5. API Design

### [Endpoint Group: e.g., "Authentication"]

| Method | Path | Auth | Description |
|--------|------|------|-------------|
| POST | /api/path | None / JWT / Service Role | [What it does] |

#### `POST /api/path`

- **Request:** [Shape]
- **Response:** [Shape]
- **Errors:** [Error codes and meanings]

---

## 6. Key Technical Decisions

| # | Decision | Options Considered | Choice | Rationale |
|---|---------|-------------------|--------|-----------|
| 1 | [What technology/approach to use] | [Option A, Option B, Option C] | [Chosen option] | [Why] |

---

## 7. Security Architecture

### Authentication

| Component | Technology | Responsibility |
|-----------|-----------|----------------|
| [Auth component] | [Technology] | [What it does] |

### Data Encryption

| Layer | Method |
|-------|--------|
| In transit | [e.g., TLS 1.3] |
| At rest | [e.g., Provider default AES-256] |
| Sensitive fields | [e.g., Application-level encryption / deferred] |

### API Security

- [Security rule 1]
- [Security rule 2]

---

## 8. Environment Variables

> **If the project has an ENVIRONMENTS.md document, the complete reference tables live there. This section should summarize scope and access patterns only, with a cross-reference.**

### [Service Name: e.g., "Frontend"]

| Variable | Scope | Description | Example |
|----------|-------|-------------|---------|
| `VITE_API_URL` | Public | [What it's for] | `https://...` |
| `SECRET_KEY` | Server-only | [What it's for] | (never in frontend) |

[Repeat per service]

**Rule:** `VITE_` prefixed vars are bundled into client JS. Everything else is server-only. Never commit `.env.local` to git.

---

## 9. Error Handling

| Code | Meaning | When |
|------|---------|------|
| `[ERROR_CODE]` | [Human meaning] | [When it occurs] |

### Retry Policy

[Describe retry behavior: how many retries, backoff strategy, when to give up]

---

## 10. Design System Tokens (if applicable)

```css
:root {
  /* Colors */
  --color-bg: [value];
  --color-text: [value];
  --color-accent: [value];

  /* Typography */
  --font-sans: [stack];
  --text-base: [value];

  /* Spacing */
  --space-sm: [value];
  --space-md: [value];

  /* Radius */
  --radius-md: [value];
}
```

---

## 11. Infrastructure & Deployment

| Component | Platform | Region | Notes |
|-----------|----------|--------|-------|
| [Frontend] | [e.g., Vercel] | [region] | [Notes] |
| [Backend] | [e.g., Supabase] | [region] | [Notes] |
| [Agent/Worker] | [e.g., LiveKit Cloud] | [region] | [Notes] |

---

## 12. Corrections and Decisions

| # | What We Tried | Why It Was Wrong | What We Do Instead | Why Not To Revisit |
|---|--------------|------------------|--------------------|--------------------|
| 1 | [Technical approach, schema, or technology that was tried] | [What went wrong — the failure mode, conflict, or realization] | [The approach that replaced it] | [The structural reason this won't work for this project, not just "we didn't like it"] |

---

## 13. Open Architecture Decisions

| # | Decision | Affects | Options | Current Choice |
|---|---------|---------|---------|---------------|
| 1 | [Undecided technical choice] | [What it impacts] | [Options] | [Interim choice, if any] |

---

## 14. Future Architecture (TODO)

- [What's coming in later phases, not now]
- [What the engineer must NOT build yet]

---

*[End of ARCHITECTURE.md]*