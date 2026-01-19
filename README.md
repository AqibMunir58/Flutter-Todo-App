Flutter Todo App
Project Overview

The Flutter Todo App is a simple and visually appealing task management application built using Flutter and GetX. The app allows users to add, edit, delete, and mark tasks as complete. All tasks are persistently stored using Hive, a lightweight local database for Flutter. The app is fully responsive and works on Android, iOS, Web, and Desktop platforms.

Project Purpose

This project demonstrates:

Building a complete cross-platform Flutter application.

Managing state efficiently using GetX.

Persisting data locally using Hive.

Implementing animated UI components like animated lists, cards, and buttons.

Organizing code using clean architecture principles (separation of domain, controllers, and UI).

Project Architecture

The project follows a clean and maintainable folder structure:

flutter_todo_app/
│
├─ lib/
│  ├─ features/
│  │  ├─ todo/
│  │  │  ├─ controllers/       # GetX controllers
│  │  │  ├─ domain/
│  │  │  │  └─ entities/       # Todo entity class
│  │  │  ├─ presentation/
│  │  │  │  ├─ screens/        # UI screens (TodoScreen, AddTodoScreen)
│  │  │  │  └─ widgets/        # Custom widgets like TodoCard
│  └─ main.dart                 # App entry point
│
├─ pubspec.yaml                  # Dependencies
└─ README.md

Features

Add Todo: Add new tasks with title and description.

Delete Todo: Remove tasks individually.

Mark as Complete: Toggle tasks as completed or incomplete.

Persistent Storage: All tasks saved locally using Hive.

Animated UI: Smooth animations for list insertion, deletion, and toggling tasks.

Cross-Platform Support: Works on Android, iOS, Web, and Desktop.

Packages Used

The following Flutter packages are used in this project:

Package	Purpose
get
	State management and navigation
hive
	Lightweight local database for storing todos
hive_flutter
	Flutter bindings for Hive
flutter/material.dart
	UI components
flutter/cupertino.dart
	iOS-style UI components
Screens

Todo Screen

Shows a list of all todos.

Toggle completion, delete items.

Floating action button to add new todos.

Add Todo Screen

Add title and description.

Animated UI for inputs and buttons.