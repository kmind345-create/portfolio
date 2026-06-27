# Flutter Portfolio — Alex Dev 💙

A fantastic, animated Flutter developer portfolio with custom 2D animations, particle effects, and smooth scroll reveals.

## ✨ Features

- **Animated Widget Tree** — Custom `CustomPainter` that draws your Flutter widget tree assembling itself node by node
- **Particle System** — 60 floating particles with connecting constellation lines, built with `CustomPainter` + `AnimationController`
- **Typewriter Hero** — Rotating animated job titles using `animated_text_kit`
- **Animated Skill Bars** — Smooth fill animations triggered on scroll visibility
- **Project Cards** — Hover glow effects with scale & shadow animations
- **Experience Timeline** — Pulsing dot timeline with staggered slide-in reveals
- **Scroll Reveal** — Every section fades/slides in using `VisibilityDetector`
- **Responsive** — Works on mobile, tablet, and desktop (web + native)
- **Dark theme** — Deep space color palette with cyan, green, purple & amber accents

## 🚀 Quick Start

### Prerequisites
- Flutter SDK ≥ 3.10.0
- Dart SDK ≥ 3.0.0

### Run the app

```bash
# Install dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome

# Run on iOS Simulator
flutter run -d ios

# Run on Android Emulator
flutter run -d android

# Run on macOS
flutter run -d macos
```

### Build for production

```bash
# Web
flutter build web --release

# Android APK
flutter build apk --release

# iOS
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── theme/
│   └── app_theme.dart           # Color palette + TextTheme
├── data/
│   └── portfolio_data.dart      # All your content (edit this!)
├── models/
│   └── portfolio_models.dart    # Data models
├── animations/
│   ├── particles_widget.dart    # Floating particles background
│   └── widget_tree_animation.dart # Flutter widget tree painter
├── widgets/
│   ├── nav_bar.dart             # Sticky navigation bar
│   ├── project_card.dart        # Animated project cards
│   ├── animated_skill_bar.dart  # Skill progress bars
│   ├── experience_timeline.dart # Timeline with pulsing dots
│   ├── contact_section.dart     # Contact buttons + footer
│   ├── reveal_on_scroll.dart    # Scroll-triggered reveal wrapper
│   └── section_header.dart     # Eyebrow + title + accent bar
└── screens/
    └── home_screen.dart         # Main page (all sections composed here)
```

## ✏️ Customizing Your Portfolio

Open `lib/data/portfolio_data.dart` and edit:

```dart
static const String name = 'Your Name';
static const String email = 'you@email.com';
static const String github = 'https://github.com/yourusername';
// ... projects, skills, experience
```

### Changing Colors
Edit `lib/theme/app_theme.dart`:
```dart
static const Color cyan = Color(0xFF00D4FF);   // Primary accent
static const Color green = Color(0xFF00FF88);  // Secondary accent
static const Color purple = Color(0xFF7C3AED); // Tertiary
static const Color amber = Color(0xFFFFB800);  // Quaternary
```

### Adding URL Launcher
Uncomment the `url_launcher` calls in `contact_section.dart` and `project_card.dart`:
```dart
import 'package:url_launcher/url_launcher.dart';
// Then:
launchUrl(Uri.parse(url));
```

## 📦 Dependencies

| Package | Purpose |
|---|---|
| `google_fonts` | Space Grotesk typography |
| `animated_text_kit` | Typewriter hero text |
| `visibility_detector` | Scroll-triggered animations |
| `url_launcher` | Open links |
| `flutter_animate` | Staggered entry animations |

## 🌐 Deploy to Web

```bash
flutter build web --release
# Upload the build/web/ folder to:
# - Vercel (drag & drop)
# - Netlify
# - Firebase Hosting: firebase deploy
# - GitHub Pages
```

---

Built with Flutter 💙 by Alex Dev
