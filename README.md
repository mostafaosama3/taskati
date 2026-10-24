# Taskati 📋

**Taskati** is a Flutter application designed to help users organize and manage their daily tasks through a clean and user-friendly interface.

## ✨ Features

- 📋 Task management and organization
- 💾 Local data storage using Hive
- 🌙 Light and dark theme support
- 🎨 Custom UI themes and styling
- 🖼️ Image selection support
- 📅 Date selection and formatting
- 🎬 Smooth animations using Lottie
- 📱 Built with Flutter for mobile development

## 🛠️ Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Local Storage:** Hive CE
- **Animations:** Lottie
- **Icons & Graphics:** Flutter SVG
- **Image Handling:** Image Picker
- **Date & Time:** Intl, Date Picker Timeline
- **UI Components:** Flutter Slidable, Percent Indicator

 
## 📸 App Screenshots

### ☀️ Light Mode

<table>
  <tr>
    <td><img src="screenshots/Splash Light Mode.png" width="180" alt="Light Mode Splash" /></td>
    <td><img src="screenshots/Light Mode Profile Screen.png" width="180" alt="Light Mode Profile" /></td>
    <td><img src="screenshots/Light Mode Home Screen.png" width="180" alt="Light Mode Home" /></td>
    <td><img src="screenshots/Light Mode Tasks Screen.png" width="180" alt="Light Mode Tasks" /></td>
  </tr>
</table>

### 🌙 Dark Mode

<table>
  <tr>
    <td><img src="screenshots/Splash Dark Mode.png" width="180" alt="Dark Mode Splash" /></td>
    <td><img src="screenshots/Dark Mode Profile Screen.png" width="180" alt="Dark Mode Profile" /></td>
    <td><img src="screenshots/Dark Mode Home Screen.png" width="180" alt="Dark Mode Home" /></td>
    <td><img src="screenshots/Dark Mode Tasks Screen.png" width="180" alt="Dark Mode Tasks" /></td>
  </tr>
</table>


## 🚀 Getting Started

### Prerequisites

Make sure you have installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Git](https://git-scm.com/)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/mostafaosama3/taskati.git
   ```

2. Navigate to the project directory:

   ```bash
   cd taskati
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## 📂 Project Structure

```text
taskati/
├── android/
├── assets/
│   ├── images/
│   ├── icons/
│   ├── lottie/
│   └── fonts/
lib/
├── core/
│   ├── constants/
│   ├── functions/
│   ├── hive/
│   ├── models/
│   ├── services/
│   │   └── local/
│   ├── styles/
│   └── widgets/
│
├── feature/
│   ├── create_task/
│   ├── home/
│   ├── splash/
│   └── upload/
│
└── main.dart
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

## 🧰 Development

To check the project for Flutter and Dart issues, run:

```bash
flutter analyze
```

To run the available tests, use:

```bash
flutter test
```

## 👨‍💻 Author

**Mostafa Osama**

- GitHub: [@mostafaosama3](https://github.com/mostafaosama3)


⭐ If you find this project interesting, consider giving the repository a star!
