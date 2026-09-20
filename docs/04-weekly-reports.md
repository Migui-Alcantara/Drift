## Week 1 (September 13–20)

## **Done this week**

- Set up the Drift Flutter project and GitHub repository.
- Created the initial Flutter app structure and confirmed that the project builds and runs.
- Added the Welcome screen with a Get Started button.
- Created the Home screen based on the approved mockup.
- Added the four main navigation panels:
  - Scenes
  - Sounds
  - Music
  - To-do
- Implemented the bottom-sheet navigation so each panel opens over the Home screen.
- Added the initial UI for the Scenes, Sounds, Music, and To-do panels.
- Added basic widget tests for the Welcome screen and navigation to the Home screen.
- Updated the project documentation and design documentation to reflect the current project direction.

## **In progress**

- The main screens currently have their UI structure in place, but most features are still visual and are not fully functional.
- Scene selection, ambient sound controls, music playback, the Pomodoro timer, and the To-do list still need their actual functionality.
- Persistence for tasks, timer settings, and user preferences has not been implemented yet.

## **Blocked or stuck on**

- No major blockers this week.
- The main challenge was making sure the navigation matched the mockup. I initially considered switching between full screens, but changed the approach to use bottom sheets so the Home screen stays underneath the selected panel.

## **Decisions made, and why**

- Kept the Home screen as the main session screen because it is the central part of the Drift experience.
- Used bottom sheets for Scenes, Sounds, Music, and To-do because this matches the approved mockup and allows users to return to the Home screen easily.
- Kept the first week focused on the UI structure and navigation instead of implementing every feature at once. This gives the project a working foundation before adding state, audio, timers, and persistence.
- Used the existing design system and mockup as the main reference for the initial UI.

**Hours spent, roughly:** 6–7 hours

## **Next week I will:**

- Start making the main features functional.
- Implement scene selection.
- Begin implementing the To-do list and its state.
- Start the Pomodoro timer.
- Research and prototype the audio/music functionality.
- Continue updating the documentation and report progress through commits.
