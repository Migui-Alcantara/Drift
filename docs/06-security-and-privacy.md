# Security and privacy

This repository is public. Fill this in honestly and date it; it is checked as part of grading.

**Last checked:** 2026-09-27

## What this app stores

| Data                       | Where it lives                     | Who can see it                    |
| -------------------------- | ---------------------------------- | --------------------------------- |
| User's task list           | In the app's current runtime state | Only the user while using the app |
| Timer/session state        | In the app's current runtime state | Only the user while using the app |
| Scene and music selections | In the app's current runtime state | Only the user while using the app |

Drift currently does not use persistent storage, a database, or a cloud service. Persistent storage using `shared_preferences` is planned for a later implementation.

## Secrets

* Values my app needs at run time: None currently.
* Where they live locally: No `.env` file or other runtime secret is currently required.
* Where the deploy workflow gets them: No application secrets are currently required.
* Anything my deployed web build carries that a visitor could read, and why that is acceptable: The application currently does not use a backend service or private API key.

## What protects the data on the service side

Drift currently does not send user data to a server or third-party backend. The application does not use Firebase, Supabase, a database, or another cloud data service, so there are currently no service-side security rules or RLS policies.

## Checklist

* [ ] `.env` (or `env.json`) is in `.gitignore`, and `.env.example` is committed
* [ ] `git log -p | grep -i "api_key\|secret\|password\|token"` finds nothing real
* [x] No service account file, keystore or `service_role` key anywhere in the repo
* [ ] Security rules or RLS policies written and tested, not left open
* [x] No real personal data in sample data, screenshots or the video
* [x] No course or university credentials anywhere
* [x] Anyone whose data appears in a test was asked first

No application secrets or API keys are currently required by Drift.
