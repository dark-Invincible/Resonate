# How to Run the Resonate App

## ✅ Prerequisites Check

```powershell
# Navigate to project directory
cd c:\Users\ASUS\Downloads\lmniit\Resonate

# Add Flutter to PATH
$env:Path = "C:\src\flutter\bin;" + $env:Path

# Verify Flutter is installed
flutter --version

# Verify devices/emulators available
flutter devices
```

---

## 🚀 Option 1: Run on Windows Desktop (Recommended for Development)

### Step 1: Get Dependencies
```powershell
cd c:\Users\ASUS\Downloads\lmniit\Resonate
$env:Path = "C:\src\flutter\bin;" + $env:Path
flutter pub get
```

**Expected output:**
```
Running "flutter pub get" in Resonate...
Got dependencies in X.Xs.
```

### Step 2: Run on Windows
```powershell
flutter run -d windows
```

**What happens:**
- App builds and launches in a window
- Hot reload enabled (press `r` to reload)
- Full debugger support

**After running:**
- Navigate to **Settings/Themes** page
- See the new **Light Mode toggle** at the top
- Click to switch between light and dark modes
- Change color themes independently
- Refresh app - settings persist!

---

## 🌐 Option 2: Run on Web (Chrome/Edge)

### Step 1: Get Dependencies
```powershell
flutter pub get
```

### Step 2: Run on Web
```powershell
flutter run -d chrome
```

Or use Edge:
```powershell
flutter run -d edge
```

**Benefits:**
- No native compilation needed
- Instant hot reload
- Easy to test on desktop browser
- DevTools inspection

---

## 📱 Option 3: Run on Android (Requires Android Emulator)

First, you need Android Studio setup (from `flutter doctor` output). Once set up:

```powershell
# List available emulators
flutter emulators

# Start an emulator (example)
flutter emulators --launch Pixel_4_API_30

# Run app
flutter run -d <emulator-id>
```

---

## ⚡ Quick Start (Copy & Paste)

### Windows Desktop:
```powershell
cd c:\Users\ASUS\Downloads\lmniit\Resonate
$env:Path = "C:\src\flutter\bin;" + $env:Path
flutter pub get
flutter run -d windows
```

### Chrome Web:
```powershell
cd c:\Users\ASUS\Downloads\lmniit\Resonate
$env:Path = "C:\src\flutter\bin;" + $env:Path
flutter pub get
flutter run -d chrome
```

---

## 🔧 Useful Commands During Development

| Command | What it does |
|---------|-------------|
| `r` | Hot reload (while app is running) |
| `R` | Hot restart (rebuild app state) |
| `q` | Quit the app |
| `flutter run -d windows --profile` | Release mode (faster) |
| `flutter clean` | Clean build files (if issues arise) |
| `flutter pub get` | Update dependencies |
| `flutter doctor -v` | Diagnose issues |

---

## 🧪 Testing the Light Mode Feature

1. **Run the app**
   ```powershell
   flutter run -d windows
   ```

2. **Navigate to Settings → Themes**
   - Look for the **Light Mode** toggle at the top
   - Notice it has a sun/moon icon

3. **Test Light Mode Toggle**
   - Toggle on/off
   - Watch UI change instantly
   - Try with different color themes
   - Verify it persists after restart

4. **Test with Different Themes**
   - Select different color themes (Classic, Forest, Amber, etc.)
   - Toggle light/dark mode with each theme
   - Light/dark should work independently

5. **Verify Persistence**
   - Change theme + brightness
   - Close and restart app
   - Settings should be restored exactly

---

## 🛠️ Troubleshooting

### "flutter: command not found"
```powershell
# Add Flutter to PATH for this session
$env:Path = "C:\src\flutter\bin;" + $env:Path

# Or add permanently (Windows Environment Variables)
# Add C:\src\flutter\bin to System Path
```

### Build fails
```powershell
# Clean and rebuild
flutter clean
flutter pub get
flutter run -d windows
```

### Hot reload not working
```powershell
# Do a hot restart instead
# Press 'R' while app is running (capital R)
```

### Dependency issues
```powershell
flutter pub upgrade
flutter pub get
flutter run -d windows
```

---

## 📊 Project Structure

```
Resonate/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── themes/
│   │   ├── theme_controller.dart    # ✨ OPTIMIZED - Light mode state
│   │   ├── light_mode_toggle.dart   # ✨ NEW - Toggle widget
│   │   ├── theme_screen.dart        # ✨ UPDATED - With toggle UI
│   │   └── ... other theme files
│   ├── views/                       # UI screens
│   ├── controllers/                 # Business logic
│   └── ... other folders
├── pubspec.yaml                     # Dependencies
├── LIGHT_MODE_FEATURE.md            # Feature documentation
└── OPTIMIZATION_ANALYSIS.md         # Implementation details
```

---

## ✨ Quick Demo Script

Once the app is running:

```
1. App opens in light mode
2. Go to Settings → Themes
3. Toggle Light Mode switch → Changes to dark
4. Select "Forest" theme → Dark forest theme
5. Toggle Light Mode again → Light forest theme
6. Select "Amber" theme → Dark amber theme
7. Close app
8. Reopen → Previous theme restored!
```

All settings persist automatically! 🎉
