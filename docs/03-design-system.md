# Design system

The Drift design system defines the visual language and reusable UI components used throughout the app. It provides the color palette, typography, spacing rules, and reusable components used when building new screens.

The complete visual design system is available below:

[View the Drift Design System (PDF)](assets/Design_System_Drift.pdf)

## Palette

Drift uses a dark color palette designed to support its cozy, nighttime lo-fi atmosphere.

| Role | Color | Used for |
|---|---|---|
| Primary | `#A78BFA` | Main buttons and active states |
| On Primary | `#0F1117` | Text and icons on primary elements |
| Secondary | `#5D5491` | Highlights and secondary actions |
| Background | `#0F1117` | Main application background |
| Surface | `#1E2130` | Cards, sheets, and dialogs |
| Error | `#F87171` | Validation and destructive actions |
| Text | `#FFFFFF` | Body text and text on the background |

The design uses dark mode as part of the app's visual style. The design system also includes a contrast check for the tested text and background combinations. :contentReference[oaicite:1]{index=1}

## Type scale

Drift uses Nunito for headings and DM Sans for body and caption text.

| Style | Font | Size | Weight | Used for |
|---|---|---:|---|---|
| Heading | Nunito | 24 px | Bold | Screen titles |
| Body | DM Sans | 14 px | Regular | Normal text |
| Caption | DM Sans | 12 px | Regular | Timestamps and hints |

These typography choices are mapped to Flutter `TextTheme` slots in the design system. :contentReference[oaicite:2]{index=2}

## Spacing

Drift uses a 4 px base spacing unit.

| Token | Size |
|---|---:|
| XS | 4 px |
| SM | 8 px |
| MD | 16 px |
| LG | 24 px |

Additional spacing rules include:

- Screen edge padding: 16 px
- Gap between list items: 8 px
- Gap between sections: 24 px

These values are represented as reusable spacing constants in Flutter.

## Components

The design system defines the following reusable components:

| Component | File | Parameters | Appears on |
|---|---|---|---|
| Buttons | `app_button.dart` | `label`, `onPressed`, `type` | Home, To-do |
| Sliders | `app_slider.dart` | `value`, `onChanged`, `min`, `max` | Sound Mixer |
| Icons | `app_icon.dart` | `icon`, `size`, `color` | All screens |
| To-do List Row | `todo_list_row.dart` | `text`, `done`, `onChanged` | To-do |
| Track State | `track_state.dart` | `title`, `isPlaying`, `onPlay`, `onNext`, `onPrevious` | Music |

These components were given intended file locations, constructor parameters, and screen usage so the visual design can be translated into reusable Flutter widgets.

## Changes since the last version

### Palette

The original design used hand-picked colors for Drift's dark visual style. The revised version assigns these colors to Flutter `ColorScheme` roles and includes `on` colors and a contrast check.

This change was made because building the app showed that the colors needed clearer roles when translated into Flutter.

### Type scale

The original typography choices were retained:

- Nunito Bold, 24 px for headings
- DM Sans Regular, 14 px for body text
- DM Sans Regular, 12 px for captions

The revision maps these choices to Flutter `TextTheme` slots to make their implementation more explicit.

### Spacing

The spacing system was revised into reusable 4, 8, 16, and 24 px tokens. Screen padding, list-item gaps, and section gaps were also defined explicitly.

This makes spacing decisions more consistent and easier to apply while building the app.

### Components

The original design identified reusable components visually. The revised version adds an intended file location, constructor parameters, and screen usage for each component.

This was added because moving from a visual design into Flutter requires clearer implementation details for reusable UI pieces. :contentReference[oaicite:9]{index=9}
