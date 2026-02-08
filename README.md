## 🏗 Architecture Overview

This project follows a **modular, layered architecture** that clearly separates responsibilities across the application.  
The goal is to ensure scalability, maintainability, and testability.

---

### 📱 Presentation Layer
Responsible for UI rendering and user interaction.

- `Views/` → SwiftUI screens and reusable components  
- `ViewModels/` → State management and presentation logic  

This layer communicates with the Domain layer but contains **no business logic**.

---

### 🧠 Domain Layer
Contains the core business logic of the application.

- `UseCases/` → Application-specific business rules  
- `Models/` → Pure domain models  
- `Protocols/` → Abstractions for repositories and services  

This layer is independent of frameworks and external implementations.

---

### 🌐 Data Layer
Handles all data-related operations.

- `Repositories/` → Repository implementations  
- `Remote/` → API calls and networking logic  
- `Mappers/` → DTO-to-domain model transformations  

This layer implements the protocols defined in the Domain layer.

---

## 🎯 Benefits of This Architecture

- Clear separation of concerns  
- Improved testability (especially Domain & ViewModels)  
- Easy scalability and feature expansion  
- Better maintainability over time  
- Reduced coupling between UI and data sources  
