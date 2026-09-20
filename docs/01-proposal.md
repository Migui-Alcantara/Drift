# Proposal

Paste in the proposal you submitted, and replace it with the final version when
the project is done. You do not need to keep it in sync week to week: nobody
reads this folder until you hand the project in.

Keep these headings so a reader can scan it:

## The problem, in one sentence
Students who want to study or do focused work end up switching between multiple apps for a
timer, music, and task list, breaking their focus every time and none of those apps feel calm enough
to actually want to open them.

## Who it is for
Students who need to do focused work (studying, assignments, personal projects) but struggle to
get into and stay in a productive headspace. Specifically people who are already into lo-fi music or
cozy aesthetics because they know the vibe they want, they just don't have one app that does it all.

## Core features
- Background scenes — Users can choose from different cozy visual scenes to create a relaxing atmosphere while they study or work.
- Ambient sound mixer — Users can mix different ambient sounds, such as rain or other background noises, and adjust their individual volume levels.
- Music player — Users can play and control music while working, including basic controls such as play, pause, and changing tracks.
- Pomodoro timer — A focus timer that uses the Pomodoro technique, allowing users to work for a set amount of time followed by a short break.
- To-do list — Users can add tasks, mark them as completed, and keep track of what they need to accomplish during their study or work session.

## Out of scope, and why
- User accounts and social features — Drift is intended to be a personal focus tool, so accounts, profiles, following, and social features are unnecessary for the project's core purpose.
- Online collaboration — Real-time collaboration and shared task lists would add significant complexity without being necessary for an individual study session.
- Advanced music streaming — Drift will not attempt to become a full music-streaming service. Music playback will be limited to the functionality needed for the focus experience.
- Highly customizable scenes — Users will choose from the scenes provided by the app rather than having a full scene editor. This keeps the project focused on the experience instead of creating a separate customization system.


## Data the app remembers, and where it is saved
- To-do tasks — The tasks the user has added, including whether they have been completed.
- Timer settings — The user's preferred Pomodoro work and break durations.
- User preferences — Settings and preferences that customize the user's experience in the app.

The project will use local device storage rather than requiring a user account. The exact storage approach will be based on the persistence implementation used in the final version of the app. Options considered during development include shared_preferences and a local database.

## Risks
- Audio playback — Audio can be more complicated than the other features because of platform differences, playback state, and handling play/pause behavior. A small prototype will be used early to make sure the required audio functionality is practical.
- State management — Keeping the selected scene, music state, timer, and to-do items consistent across different screens could become difficult as the app grows. The implementation will be kept simple and tested as features are added.

## Changes since the last version
- September 2026 — Persistence clarified: Data persistence was added as an explicit part of the plan. The app will prioritize saving essential local data such as to-do items instead of depending on a cloud backend.
- September 2026 — Audio risk identified: Audio playback was identified as a development risk because it introduces additional state and platform considerations. A prototype will be used to test this before committing to more complex audio functionality.
- September 2026 — Interface refined: The navigation and screen structure were clarified around the main Drift experience, with scenes, music/sounds, and the to-do list forming the main areas of the app.
