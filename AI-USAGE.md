# Builds with Flutter and AI

## The three sections of `AI-USAGE.md`

## 1. How I used AI (35 points)

At least six entries. One per real use. Each entry says:

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
I changed a bit of the content and styling to match my own Drift mockup and design system but honestly it was good as it is.

**Commit:**  
[Updated Drift each screen](https://github.com/Migui-Alcantara/Drift/commit/afffe922d5ba02dc297ec1322f11b928df164f64)

**Being honest about using AI a lot does not cost you marks.** This section
rewards an accurate account, not a small one.

---

### 2. Where the AI got it wrong (25 points)

In progress...

Three times the AI gave you something wrong, unsafe, out of date, or just worse
than what you did instead. For each one: what it gave you, what was wrong with
it, what you did instead, and the commit link.

This section is worth real points because it is the hard part. Taking good code
is not a skill. Catching bad code is. If you write that the AI was never wrong,
this section scores zero, so do not be tempted.

### 3. Who wrote what (30 points)

In progress...

This is the 80 percent rule, made checkable.

Name the parts of the project **you** wrote yourself. For each one give the file,
the commit, and a short explanation in your own words: what it does, and why it
is built that way. A widget you built yourself, or the place your state actually lives is a good
example of the kind of thing to pick.

Then do the same for the one piece of AI-written code you understand best.

What earns full marks here is the **explanation**, not who typed it. "The AI
wrote this and here is exactly what it does and why we kept it" is a strong
answer. A list of filenames with no explanation is a weak one, no matter who
wrote them.

If you cannot point at any meaningful part of the project as your own, this
section scores zero, and you cannot reach the 75 points the badge needs.

