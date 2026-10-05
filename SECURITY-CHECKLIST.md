# Security checklist

## Secrets and credentials

| # | Check                                                                                                     | Yes / No / N/A | Evidence                                                                                                |
| - | --------------------------------------------------------------------------------------------------------- | -------------- | ------------------------------------------------------------------------------------------------------- |
| 1 | No API key, token or password is hardcoded in `lib/`, including in comments and commented-out code        | Yes            | I checked the Dart files in `lib/` and found no API keys, tokens, or passwords.                         |
| 2 | Anything private is in a gitignored config or passed with `--dart-define`, with an example file committed | N/A            | Drift does not currently use private configuration, API keys, or environment variables.                 |
| 3 | No keystore, `key.properties` or signing credential is in the repository                                  | Yes            | I checked the project and found no keystore, `key.properties`, or signing credentials.                  |
| 4 | Git history is clean: I searched `git log -p` for password, secret, api key and token                     | Yes            | I checked the Git history for password, secret, API key, and token references and found no credentials. |
| 5 | Any credential that was ever committed has been rotated                                                   | N/A            | No credentials have been committed to the repository, so there was nothing to rotate.                   |

## GitHub Actions

| #  | Check                                                                                                   | Yes / No / N/A | Evidence                                                                                                                               |
| -- | ------------------------------------------------------------------------------------------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| 6  | No secret value is written literally in any workflow YAML file                                          | Yes            | I checked the GitHub Actions workflow and found no secret values written directly in the workflow.                                     |
| 7  | Secrets are stored in repository Actions secrets and read with `${{ secrets.NAME }}`                    | N/A            | The Drift workflow does not require any repository secrets.                                                                            |
| 8  | No workflow step echoes, dumps or debug-prints a secret, and I opened a recent run's log to confirm     | Yes            | I checked the workflow and its build output and found no steps that print secret values.                                               |
| 9  | If I build a signed APK: the keystore is a base64 secret decoded to a file at build time, never printed | N/A            | Drift is being deployed as a Flutter web application and does not build a signed APK.                                                  |
| 10 | Uploaded build artifacts contain no key file, keystore or generated config                              | N/A            | The Drift deployment does not require or upload signing keys, keystores, or secret configuration files.                                |
| 11 | Third-party actions are pinned to a commit SHA, not a moveable tag                                      | No             | The current Drift workflow uses third-party GitHub Actions with version tags rather than pinning each action to a specific commit SHA. |
| 12 | Secret scanning and push protection are enabled on the repository                                       | Yes            | GitHub Secret scanning and Push protection are enabled for the Drift repository.                                                       |

## Backend and security rules

| #  | Check                                                                                                    | Yes / No / N/A | Evidence                                                                                                           |
| -- | -------------------------------------------------------------------------------------------------------- | -------------- | ------------------------------------------------------------------------------------------------------------------ |
| 13 | Firestore and Storage rules are not left open to anyone; they require an authenticated user              | N/A            | Drift does not use Firebase Firestore or Firebase Storage.                                                         |
| 14 | Rules restrict a user to their own documents where that makes sense                                      | N/A            | Drift does not have a backend or user documents.                                                                   |
| 15 | If Supabase: Row Level Security is on for every table                                                    | N/A            | Drift does not use Supabase.                                                                                       |
| 16 | Firebase and Google API keys are restricted in the Google Cloud console to the APIs and app they are for | N/A            | Drift does not use Firebase or Google APIs.                                                                        |
| 17 | I opened the app signed out and confirmed I could not read or write data I should not                    | N/A            | Drift has no account system or backend data requiring authentication.                                              |
| 18 | Seed and sample data is invented, not real people's data                                                 | Yes            | The sample to-do tasks and other sample content used in Drift are fictional and do not contain real people's data. |

## Input and app surface

| #  | Check                                                                                    | Yes / No / N/A | Evidence                                                                        |
| -- | ---------------------------------------------------------------------------------------- | -------------- | ------------------------------------------------------------------------------- |
| 19 | Input is validated before it is written, not only styled as valid in the UI              | Yes            | The To-do input is trimmed and only added when the resulting text is not empty. |
| 20 | Nothing secret is recoverable from the built app, since a shipped binary can be unpacked | Yes            | The app contains no API keys, passwords, tokens, or other private credentials.  |

## Repository and privacy

| #  | Check                                                                                                   | Yes / No / N/A | Evidence                                                                                                                                            |
| -- | ------------------------------------------------------------------------------------------------------- | -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| 21 | No student number, personal email, phone number or home address in the repository or in commit messages | Yes            | I checked the project content and did not add student numbers, phone numbers, home addresses, or personal email addresses to the application files. |
| 22 | No classmate's personal data in the repository                                                          | Yes            | I checked the project content and sample data and found no classmates' personal information.                                                        |
| 23 | Dependencies come from pub.dev, and `build/` and `.dart_tool/` are gitignored                           | Yes            | Flutter dependencies are declared in `pubspec.yaml`, and generated Flutter files and folders are excluded through `.gitignore`.                     |
| 24 | Images, fonts and other assets are mine, licensed, or credited                                          | Yes            | The images, audio, and other assets used in Drift were obtained from sources that allow free use for projects.                                      |
| 25 | Repository visibility is deliberate, and I checked it after my last push                                | Yes            | The Drift repository is intentionally public for the final project and deployment, and I checked the repository after pushing the latest changes.   |

## Anything I found and fixed

The security checklist did not identify any major security issues because Drift is a local Flutter application and does not use a backend, authentication system, or private API credentials. I checked the project for credentials and personal information and made sure that the sample data used by the app does not contain real people's information.
