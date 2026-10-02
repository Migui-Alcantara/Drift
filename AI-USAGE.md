# Builds with Flutter and AI

## The three sections of `AI-USAGE.md`

## 1. How I used AI (35 points)

### 1. Flutter navigation structure

**Date:** September 19, 2026  
**Tool:** ChatGPT

**What I asked for:**  
Help designing the Flutter navigation structure for Drift based on my mockup, specifically how the Scenes, Sounds, Music, and To-do panels should open while keeping the Home screen underneath.

**What it gave back:**  
ChatGPT gave a Flutter modal bottom sheets instead of navigating to completely separate screens.

**What I kept:**  
I kept the bottom-sheet approach because it matched the interaction shown in my mockup.

**What I changed:**  
I adapted the structure into my own `HomeScreen` and separate the screen files for each panel.

**Commit:**  
[Update Drift welcome and home screens](https://github.com/Migui-Alcantara/Drift/commit/af314e2616dddca4d4404e7c7f9d7353165e8e53#diff-935e56a557f0ab902a679f47de66345d9f47058bccb96f870e6383d19e2c86dd)

---

### 2. Initial Flutter screen structure

**Date:** September 19, 2026
**Tool:** ChatGPT

**What I asked for:**  
Help creating the initial Flutter screen structure for Drift, including the Welcome screen, Home screen, Scenes, Sounds, Music, and To-do screens.

**What it gave back:**  
ChatGPT provided example Flutter code and suggested organizing the screens into separate files.

**What I kept:**  
I kept the general file structure and some of the basic Flutter widget patterns.

**What I changed:**  
I changed a bit of the content and styling to match my own Drift mockup and design system but kept mostly the general structure of it.

**Commit:**  
[Updated Drift each screen](https://github.com/Migui-Alcantara/Drift/commit/afffe922d5ba02dc297ec1322f11b928df164f64)


---

### 3. To-do list implementation

**Date:** September 25, 2026
**Tool:** ChatGPT

**What I asked for:**
Help implementing the To-do list feature for Drift based on my mockup, including adding tasks, marking tasks as completed, and deleting tasks.

**What it gave back:**
ChatGPT provided Flutter code for creating a To-do list with task objects, text input for adding new tasks, checkboxes for completing tasks, and delete buttons for removing tasks.

**What I kept:**
I kept the general structure for the task list and the basic add, complete, and delete functionality.

**What I changed:**
I adapted the code to match my Drift design and connected the To-do list to the existing HomeScreen and bottom-sheet navigation.

**Commit:**
[Implement functional todo list](https://github.com/Migui-Alcantara/Drift/commit/3c5f63ac68210924ab2fb7fec2d6f24bdac6572c)

---

### 4. Ambient sounds and audio playback

**Date:** September 26, 2026
**Tool:** ChatGPT

**What I asked for:**
Help implementing the Sounds panel so Drift could play ambient sounds from local audio assets, with multiple sounds playing at the same time and individual volume controls.

**What it gave back:**
ChatGPT suggested using the `audioplayers` package and creating separate `AudioPlayer` instances for the ambient sounds. It also provided the structure for looping sounds and controlling their volume with sliders.

**What I kept:**
I kept the `audioplayers` approach, the separate players for each sound, looping playback, and individual volume controls.

**What I changed:**
I adapted the code to use my own ambient sound data and audio files, including Rain, Radio Noise, Birds, Wind, and Fireplace. I also connected the controls to the existing Drift interface.

**Commit:**
[Implement ambient sounds](https://github.com/Migui-Alcantara/Drift/commit/c2f6273ff87fdec7a63b7d55adb371d7e5c121c8)

---

### 5. Saving user settings and app state

**Date:** September 28, 2026
**Tool:** Claude

**What I asked for:**
Help making Drift remember user changes after closing and reopening the app, including the selected scene, to-do tasks, music settings, and ambient sound settings.

**What it gave back:**
Claude suggested using the `shared_preferences` package to store simple app settings and provided code for saving and loading the different pieces of state.

**What I kept:**
I kept `shared_preferences` because the information being saved was simple app state and did not require a full database.

**What I changed:**
I adapted the saved values to Drift's actual features. The app now saves the selected scene, to-do tasks, music track, music volume, music playing state, ambient sound volumes, and currently playing ambient sounds.

**Commit:**
[Added persistence to sounds, tasks, scene, and music settings](https://github.com/Migui-Alcantara/Drift/commit/ae1e52405c9b5fbba812a4e47447a67f9c8f4552)

---

### 6. Music restart and playback behavior

**Date:** September 28, 2026
**Tool:** ChatGPT

**What I asked for:**
Help fixing the music behavior when restarting Drift. I wanted the selected music and playback state to be remembered, but I did not want the exact playback position to be saved. I also needed to prevent multiple copies of the same music from playing after restarting the app.

**What it gave back:**
ChatGPT suggested stopping and disposing of the existing `AudioPlayer` before creating a new one and starting the saved track from the beginning. It also separated the saved music state from the playback position.

**What I kept:**
I kept the approach of saving the selected track and whether music was playing, while intentionally not saving the playback position.

**What I changed:**
I adapted the music functions so that a normal app restart starts the saved track from the beginning and disposes of the previous player before starting a new one. I tested the behavior by stopping and running the Flutter app again.

**Commit:**
[Added persistence to sounds, tasks, scene, and music settings](https://github.com/Migui-Alcantara/Drift/commit/ae1e52405c9b5fbba812a4e47447a67f9c8f4552)


## 2. Where the AI got it wrong (25 points)

### 1. Incorrect `pubspec.yaml` asset structure

**What the AI gave me:**
The AI initially gave me an incorrect `pubspec.yaml` structure for the Flutter assets. It treated the asset path as a single value instead of putting the asset folders inside an asset list.

**What was wrong with it:**
Flutter gave me the error `Expected "assets" to be a list, but got assets/images/ (String).` This meant the project could not properly load the assets using the suggested configuration.

**What I did instead:**
I changed the configuration so that `assets` was a list containing the image folder:

```yaml
flutter:
  assets:
    - assets/images/
```

After changing it, Flutter accepted the configuration and the assets loaded correctly.

**Commit:**
[Implement functional scenes and fixed todo layout](https://github.com/Migui-Alcantara/Drift/commit/fcc6a6ded3a557756970277f441754fedcfc9334#diff-8b7e9df87668ffa6a04b32e1769a33434999e54ae081c52e5d943c541d4c0d25)

---

### 2. Bottom sheet did not match the approved mockup

**What the AI gave me:**
The AI initially created the panel content in a way that took up most or all of the screen when opened.

**What was wrong with it:**
This did not match my approved Drift mockup. The Home screen was supposed to remain visible behind the panel so the user could still see the selected scene, timer, and date. The panel also needed to behave more like a bottom sheet instead of replacing the whole screen.

**What I did instead:**
I changed the bottom sheet to use a fixed portion of the screen with `FractionallySizedBox`, using a height factor of `0.55`. I also adjusted the panel so its content could scroll while the rest of the Home screen remained visible underneath.

**Commit:**
[Update Drift welcome and home screens](https://github.com/Migui-Alcantara/Drift/commit/af314e2616dddca4d4404e7c7f9d7353165e8e53#diff-935e56a557f0ab902a679f47de66345d9f47058bccb96f870e6383d19e2c86dd)

---

### 3. To-do changes did not update immediately

**What the AI gave me:**
The initial To-do implementation provided by the AI did not properly refresh the open bottom sheet after a task was checked, added, or deleted.

**What was wrong with it:**
When I interacted with a task, the change was not immediately visible in the open To-do panel. For example, checking a task would only show the updated state after closing and reopening the panel.

**What I did instead:**
I changed the To-do panel and its callback/state handling so that changes were sent back to the `HomeScreen` and the open panel refreshed immediately. This allowed adding, completing, and deleting tasks without needing to close and reopen the panel.

**Commit:**
[Implement functional todo list](https://github.com/Migui-Alcantara/Drift/commit/3c5f63ac68210924ab2fb7fec2d6f24bdac6572c)

## 3. Who wrote what (30 points)

### Parts I wrote myself

#### 1. Data files

**Files:**

* `lib/data/todo_task.dart` — [Commit](https://github.com/Migui-Alcantara/Drift/commit/3c5f63ac68210924ab2fb7fec2d6f24bdac6572c)
* `lib/data/music_track.dart` — [Commit](https://github.com/Migui-Alcantara/Drift/commit/ad6bda087f9a566d685b6a956c7787a1a859c71d)
* `lib/data/ambient_sound.dart` — [Commit](https://github.com/Migui-Alcantara/Drift/commit/c2f6273ff87fdec7a63b7d55adb371d7e5c121c8)
* `lib/data/scene.dart` — [Commit](https://github.com/Migui-Alcantara/Drift/commit/fcc6a6ded3a557756970277f441754fedcfc9334)

I wrote the data files myself to keep the information used by Drift organized separately from the screen code. For example, the scene data contains the available scene information, while the ambient sound data contains the names and audio paths for the sounds used by the app. I built them this way so the screen files would not have to contain all of the app's data directly.

#### 2. Pomodoro timer logic

**File:** `lib/screens/home_screen.dart`
**Commit:** [Implement Pomodoro timer cycle](https://github.com/Migui-Alcantara/Drift/commit/511ca58b7a14c243cfcf7971a8bbf66c7dccd023)

I wrote the Pomodoro timer logic myself inside the Home screen. It keeps track of the remaining time, whether the timer is running, the current work or break period, and the number of completed sessions. It also handles starting, pausing, resetting, and automatically switching between work and break periods. I kept this logic in the Home screen because the timer is one of the main parts of the Home interface and its current state needs to be displayed there.

#### 3. Scenes screen

**File:** `lib/screens/scenes_screen.dart`
**Commit:** [Implement functional scenes and fixed todo layout](https://github.com/Migui-Alcantara/Drift/commit/fcc6a6ded3a557756970277f441754fedcfc9334#diff-8b7e9df87668ffa6a04b32e1769a33434999e54ae081c52e5d943c541d4c0d25)

I wrote the Scenes screen myself. It displays the available scenes and allows the user to select one. When a scene is selected, the selected scene is passed back to the Home screen so the background can change. I made it a separate screen/widget so the scene-selection interface would stay organized instead of putting all of the scene options directly into the Home screen.

### AI-written code I understand

#### Home screen integration

**File:** `lib/screens/home_screen.dart`
**Commit:** [home_screen.dart](https://github.com/Migui-Alcantara/Drift/commit/afffe922d5ba02dc297ec1322f11b928df164f64)

A significant part of the Home screen was created with AI assistance, and I understand how the code works because I tested and modified it throughout the project. The Home screen brings together the different Drift features, including the selected scene, music, ambient sounds, to-do list, and Pomodoro timer.

The AI-assisted parts helped connect these features and handle interactions between the Home screen and the bottom panels. I kept this general structure because it allowed the Home screen to act as the main interface while the Scenes, Sounds, Music, and To-do features could open as panels over it. I also changed the AI-generated code when it did not behave correctly, such as when state changes were not immediately reflected in an open panel and when music needed to be stopped and restarted correctly.
