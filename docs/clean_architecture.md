# Clean Architecture in Flutter

## Overview

Clean Architecture is a software design philosophy introduced by Robert C. Martin that emphasizes separation of concerns and dependency inversion. In Flutter development, it helps create scalable, testable, and maintainable applications by organizing code into distinct layers with clear responsibilities.

The core principle is that dependencies should point inward, meaning outer layers depend on inner layers, but inner layers should not depend on outer layers.

## Layers of Clean Architecture

### 1. Presentation Layer (Outer Layer)
This layer handles the UI and user interactions. It includes:
- **Widgets**: Flutter UI components
- **State Management**: BLoC, Provider, Riverpod, or other state management solutions
- **Controllers/ViewModels**: Handle UI logic and communicate with the domain layer

**Responsibilities:**
- Display data to users
- Handle user input
- Manage UI state
- Convert domain models to UI models

### 2. Domain Layer (Inner Layer)
This is the core business logic layer, independent of any external frameworks or UI.
- **Entities**: Core business objects and data models
- **Use Cases/Interactors**: Application-specific business rules
- **Repositories Interfaces**: Abstract contracts for data operations

**Responsibilities:**
- Define business rules
- Validate data
- Orchestrate complex operations
- Define data contracts

### 3. Data Layer (Outer Layer)
This layer handles data persistence and external communications.
- **Repositories**: Implement data access logic
- **Data Sources**: Handle external data (API, database, local storage)
- **Models**: Data transfer objects and external API models

**Responsibilities:**
- Fetch data from external sources
- Cache data
- Handle network requests
- Map external data to domain entities

## Dependency Flow

```
Presentation Layer → Domain Layer ← Data Layer
```

- Presentation depends on Domain
- Data depends on Domain
- Domain depends on nothing (pure business logic)

## Benefits in Flutter Development

1. **Testability**: Each layer can be tested independently
2. **Maintainability**: Changes in one layer don't affect others
3. **Scalability**: Easy to add new features without breaking existing code
4. **Technology Independence**: Can change UI framework or data sources without affecting business logic
5. **Code Reusability**: Domain logic can be reused across different platforms

## Flutter-Specific Implementation

### Recommended Patterns
- Use **BLoC Pattern** for state management in presentation layer
- Implement **Repository Pattern** for data access
- Use **Dependency Injection** (e.g., GetIt, Provider) for managing dependencies

### Project Structure Example

```
lib/
├── core/                    # Shared utilities, constants
│   ├── error/
│   ├── network/
│   └── utils/
├── presentation/            # UI Layer
│   ├── pages/
│   │   ├── home_page.dart
│   │   └── profile_page.dart
│   ├── widgets/
│   │   ├── custom_button.dart
│   │   └── user_card.dart
│   ├── blocs/               # or cubits/controllers
│   │   ├── home/
│   │   │   ├── home_bloc.dart
│   │   │   ├── home_event.dart
│   │   │   └── home_state.dart
│   │   └── profile/
│   └── routes.dart
├── domain/                  # Business Logic Layer
│   ├── entities/
│   │   ├── user.dart
│   │   └── post.dart
│   ├── usecases/
│   │   ├── get_user_profile.dart
│   │   └── create_post.dart
│   └── repositories/
│       ├── user_repository.dart
│       └── post_repository.dart
└── data/                    # Data Layer
    ├── repositories/
    │   ├── user_repository_impl.dart
    │   └── post_repository_impl.dart
    ├── datasources/
    │   ├── remote/
    │   │   ├── user_remote_datasource.dart
    │   │   └── post_remote_datasource.dart
    │   └── local/
    │       ├── user_local_datasource.dart
    │       └── post_local_datasource.dart
    └── models/
        ├── user_model.dart
        └── post_model.dart
```

## Key Principles to Follow

1. **Dependency Inversion**: High-level modules should not depend on low-level modules
2. **Single Responsibility**: Each class should have one reason to change
3. **Open-Closed**: Open for extension, closed for modification
4. **Interface Segregation**: Clients should not be forced to depend on interfaces they don't use
5. **Liskov Substitution**: Subtypes should be substitutable for their base types

## Common Flutter Clean Architecture Flow

1. User interacts with UI (Presentation Layer)
2. UI triggers a use case (Domain Layer)
3. Use case calls repository interface (Domain Layer)
4. Repository implementation fetches data (Data Layer)
5. Data is mapped to domain entities
6. Result flows back through layers to update UI

This structure provides a solid foundation for building robust Flutter applications and serves as a blueprint for creating draw.io diagrams to visualize the architecture.