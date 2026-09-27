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

**Hours spent, roughly:** 8–10 hours

## **Next week I will:**

- Start making the main features functional.
- Implement scene selection.

## Week 2 (September 21–27)

## **Done this week**

* Completed most of the main features of the Drift application based on the approved mockup.
* Implemented the main session/Home view, including the selected scene, focus timer, date, and session information.
* Implemented scene selection and connected it to the main session view.
* Implemented the To-do feature and its interactive functionality.
* Implemented the main navigation between Scenes, Sounds, Music, and To-do.
* Implemented the main Music and Sounds interfaces and their related functionality.
* Implemented the focus timer and integrated it into the main session experience.
* Fixed the scrolling behavior of the session content so users can properly view the available information.
* Adjusted the session layout so the main content does not take up the entire screen and more closely follows the approved mockup.
* Fixed state-update issues so changes made by the user are reflected immediately without needing to restart the application.
* Updated the README with the current project information, features, setup instructions, project structure, and screenshots.
* Added screenshots of the implemented screens to the project documentation.

## **In progress**

* Implementing timer settings and additional timer configuration.
* Adding local persistence using `shared_preferences` for tasks, timer settings, and user preferences.
* Refining the visual design to more closely match the approved mockup.
* Performing additional testing and UI polishing across the implemented features.

## **Blocked or stuck on**

* No major blockers this week.
* Some layout issues were encountered while implementing the session view, particularly with the content taking up too much of the screen and scrolling not working correctly. These were resolved by restructuring the layout and adjusting the scrollable content.
* Some state-update issues were also encountered during development and were fixed so that changes are reflected immediately in the interface.

## **Decisions made, and why**

* Prioritized completing the core application features before focusing on smaller visual details and additional settings.
* Kept the existing navigation structure from the approved mockup while connecting each section to its implemented functionality.
* Adjusted the session layout to display the scene, timer, date, and other information together while still allowing the user to scroll through the content.
* Continued using `shared_preferences` as the planned local storage solution because the application needs to retain user tasks, timer settings, and preferences between sessions.
* Updated the README alongside development so that the documentation reflects the actual state of the application.

**Hours spent, roughly:** 8–10 hours

## **Next week I will:**

* Implement timer settings and additional timer configuration.
* Implement local persistence using `shared_preferences`.
* Refine the UI to more closely match the approved mockup.
* Continue testing the completed features and fix any remaining bugs.
* Improve the consistency of the Music, Sounds, Scenes, and To-do interfaces.
* Complete the remaining documentation updates and continue recording progress through commits.

- Begin implementing the To-do list and its state.
- Start the Pomodoro timer.
- Research and prototype the audio/music functionality.
- Continue updating the documentation and report progress through commits.
