# SafeSpace with Flutter and Appwrite

This using **Flutter**, **Appwrite** 

---

## Features

- **User Authentication**: Secure sign-up and login powered by Appwrite.
- **Scalable Architecture**: Designed to support applications with a growing user base.
- **Server-Side Processing**: Appwrite Cloud Functions handle API requests and process responses.

---

## Tech Stack

- **Frontend**: [Flutter](https://flutter.dev/) for creating a responsive and user-friendly UI.
- **Backend**: [Appwrite](https://appwrite.io/) for authentication, database, and cloud functions.

---

## Getting Started

### Prerequisites
- Flutter SDK installed ([Installation Guide](https://docs.flutter.dev/get-started/install)).
- Appwrite server set up ([Appwrite Installation Guide](https://appwrite.io/docs/installation)).


---

### Installation Dependencies
git clone https://github.com/darianz/SafeSpace_POC.git
cd SafeSpace_POC

flutter pub get

Set Up Appwrite

Install Appwrite on your docker
Configure your Appwrite project

change all the data in appwrite_constants.dart



### Run the App
flutter run

### Architecture

Flutter Frontend:

A responsive chat interface built using Flutter widgets.

Appwrite Backend:
User authentication and real-time database.

SafeSpace_POC/
├── lib/
│   ├── main.dart                       # Entry point
│   ├── apis/                           # API and Appwrite integrations
│   ├── common/                         # Common components used accross the app
│   └── constants/                      # Reusable data components
    └── core/                           # Core components inluding enums and providers
    └── models/                         # Data Classes
    └── theme/                          # Design Data
    ├── features/                       # The Features components of the app
        ├── feature1.dart               
        ├── feature2.dart               
        ├── feature3.dart               
            ├── controller.dart         # Entry point
            ├── view.dart               # View structure
            ├── widgets.dart            # Inner view components

Switching Between Branches

To switch between branches, use:

git checkout dev  # Switch to dev branch
git checkout test  # Switch to test branch
git checkout main  # Switch to main branch

Merging Changes
Merge changes from dev to test for testing:

git checkout test
git merge dev
git push origin test
