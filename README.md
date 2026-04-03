# Project Title

This project is initialized with **Easy Init CLI** using **Clean Architecture**.

## 📂 Folder Structure

The project follows a scalable folder structure:

```
lib/
├── common/             # Common utilities and helper classes
├── core/               # Core application layers
│   ├── api_endpoints/  # API endpoint definitions
│   ├── config/         # Application configuration files
│   ├── dependency_injection/ # Dependency injection setup
│   ├── extensions/     # Dart extensions associated with core
│   ├── failures/       # Error handling and failures
│   ├── network/        # Network client and exceptions
│   ├── routes/         # Application routing
│   ├── services/       # External services integrations
│   └── theme/          # App theme, colors, and typography
├── features/           # Feature-based clean architecture modules
│   └── [feature_name]/
│       ├── data/       # Data layer (Repositories Impl, Data Sources, Models)
│       ├── domain/     # Domain layer (Entities, UseCases, Repositories)
│       └── presentation/ # Presentation layer (BLoC, Screens, Widgets)
├── main.dart           # Entry point
└── app.dart            # Main app widget
```

## 🤖 AI Vibe Coding

To get the most accurate and context-aware code generation from AI tools (Vibe Coding tool like Antigravity,Cursor etc), please refer to the documents in the `ai_docs` folder:

- **[Styling Guide](ai_docs/styling_guide.md)**: Follow this guide for UI styling, color usage, and theming.
- **[API Flow Guide](ai_docs/api_flow_guide.md)**: Follow this guide for implementing new features, API integration, and state management.

### How to use these docs with AI:
When asking the AI to implement a new feature or fix a UI issue, you can reference these files to ensure the output matches the project's standards.

**Example Prompt:**
> "Implement a new feature for 'User Profile' following the @[ai_docs/api_flow_guide.md] and using the styles defined in @[ai_docs/styling_guide.md]."
