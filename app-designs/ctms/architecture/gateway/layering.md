# Gateway Layered Architecture

This document describes the layered architecture of the OoBDev Gateway application, including layer dependencies and namespace constraints.

## Architecture Overview

The Gateway follows a strict layered architecture pattern to ensure separation of concerns and maintainability.

```plantuml
@startuml
title OoBDev Core - Layered Architecture

skinparam componentStyle rectangle
skinparam packageStyle rectangle

!define LAYER_BG_COLOR #E8F5E9
!define SUB_LAYER_BG_COLOR #C8E6C9

package "Client Views" as ClientViews #LAYER_BG_COLOR {
  component "OoBDev.Web\n(Controllers)" as OoBDevWeb #SUB_LAYER_BG_COLOR
}

package "Service Model" as ServiceModel #LAYER_BG_COLOR {
  component "Service Layer" as ServiceLayer
}

package "Business Model" as BusinessModel #LAYER_BG_COLOR {
  component "Web Models\n(OoBDev.Web.Models)" as WebModels #SUB_LAYER_BG_COLOR
}

package "MVC Extensions\n(OoBDev.Web.Mvc)" as MvcExtensions #LAYER_BG_COLOR {
  component "MVC Helpers" as MvcHelpers
}

package "Data Access" as DataAccess #LAYER_BG_COLOR {
  component "Repositories" as Repositories
}

package "Data Persistence" as DataPersistence #LAYER_BG_COLOR {
  component "Database" as Database
}

' Dependencies
OoBDevWeb --> ServiceLayer
ServiceLayer --> WebModels
ServiceLayer --> Repositories
OoBDevWeb --> MvcHelpers
OoBDevWeb --> WebModels
WebModels --> MvcHelpers
Repositories --> Database

note right of ClientViews
  Contains web controllers
  and presentation logic
end note

note right of ServiceModel
  Business logic and
  service orchestration
end note

note right of BusinessModel
  Domain models and
  business entities
end note

note right of DataAccess
  Data access layer with
  repository pattern
end note

note right of DataPersistence
  Database and
  persistence layer
end note

@enduml
```

### ASCII Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         OoBDev Core - Layered Architecture                  │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│  Layer 1: Client Views                                                      │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │  OoBDev.Web (Controllers)                                             │  │
│  │  - ASP.NET MVC Controllers                                            │  │
│  │  - Presentation logic                                                 │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
└────────────────────┬──────────────────────────┬─────────────────────────────┘
                     │                          │
                     ↓                          ↓
┌────────────────────────────────────┐  ┌──────────────────────────────────────┐
│  Layer 2: Service Model            │  │  Layer 4: MVC Extensions             │
│  ┌──────────────────────────────┐  │  │  ┌────────────────────────────────┐  │
│  │  Service Layer               │  │  │  │  OoBDev.Web.Mvc                │  │
│  │  - Business logic            │  │  │  │  - MVC Helpers                 │  │
│  │  - Orchestration             │  │  │  │  - Custom components           │  │
│  └──────────────────────────────┘  │  │  └────────────────────────────────┘  │
└──────────┬────────────┬────────────┘  └──────────────────┬───────────────────┘
           │            │                                   ↑
           ↓            ↓                                   │
┌──────────────────────────────────────┐                   │
│  Layer 3: Business Model             │◄──────────────────┘
│  ┌────────────────────────────────┐  │
│  │  Web Models                    │  │
│  │  (OoBDev.Web.Models)           │  │
│  │  - Domain entities             │  │
│  │  - View models & DTOs          │  │
│  └────────────────────────────────┘  │
└──────────────────────────────────────┘
           │
           ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  Layer 5: Data Access                                                       │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │  Repositories                                                         │  │
│  │  - Repository pattern implementation                                 │  │
│  │  - Query composition                                                  │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────┬────────────────────────────────────┘
                                         │
                                         ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│  Layer 6: Data Persistence                                                  │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │  Database                                                             │  │
│  │  - Entity Framework / ORM                                             │  │
│  │  - SQL Server                                                         │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘

Dependency Rules:
  → Downward dependencies only (layers depend on layers below)
  ← No upward dependencies allowed
  ↔ Bidirectional: Client Views ↔ MVC Extensions, Service Model ↔ Business Model
```

## Layer Descriptions

### 1. Client Views Layer

**Purpose**: Presentation and user interaction

**Components**:
- **OoBDev.Web** (Controllers)
  - Project: `OoBDev.Web.Controllers.csproj`
  - Required Namespace: `OoBDev.Web.Controllers`
  - ASP.NET MVC Controllers
  - View rendering logic
  - Request/response handling

**Dependencies**:
- Service Model (for business logic)
- MVC Extensions (for custom MVC components)
- Web Models (for view models and DTOs)

**Constraints**:
- Must not directly access Data Access or Data Persistence layers
- All code must be in `OoBDev.Web.Controllers` namespace

### 2. Service Model Layer

**Purpose**: Business logic orchestration and service layer

**Components**:
- Service interfaces and implementations
- Business workflow coordination
- Transaction management

**Dependencies**:
- Business Model (for domain entities)
- Data Access (for data operations)

**Constraints**:
- Must not directly access Client Views
- Must not directly access Data Persistence (use Data Access instead)

### 3. Business Model Layer

**Purpose**: Domain model and business entities

**Components**:
- **Web Models**
  - Project: `OoBDev.Web.Models.csproj`
  - Required Namespace: `OoBDev.Web.Models`
  - View models
  - Data transfer objects (DTOs)
  - Domain entities

**Dependencies**:
- MVC Extensions (for custom model behaviors)

**Constraints**:
- Should be persistence-ignorant
- No UI dependencies

### 4. MVC Extensions Layer

**Purpose**: Custom ASP.NET MVC extensions and helpers

**Components**:
- Project: `OoBDev.Web.Mvc.csproj`
- Required Namespace: `OoBDev.Web.Mvc`
- Custom model binders
- HTML helpers
- Action filters
- Custom routing

**Dependencies**:
- None (foundational layer)

**Constraints**:
- Should be reusable across projects
- No business logic

### 5. Data Access Layer

**Purpose**: Data access and repository pattern implementation

**Components**:
- Repository interfaces and implementations
- Data access logic
- Query composition

**Dependencies**:
- Data Persistence (for database access)

**Constraints**:
- Must not contain business logic
- Should abstract database details from upper layers

### 6. Data Persistence Layer

**Purpose**: Database access and ORM configuration

**Components**:
- Entity Framework / ORM configuration
- Database context
- Data migrations
- Low-level database operations

**Dependencies**:
- None (foundational layer)

**Constraints**:
- Should not be accessed directly by upper layers (except Data Access)

## Architecture Validation

The Gateway project includes architecture validation rules that are enforced at build time. Violations are tracked in `CoreLayering.layerdiagram.suppressions`.

### Current Suppressions (Technical Debt)

The following architecture violations are currently suppressed:

#### 1. System.Diagnostics.Contracts Violation
- **Layer**: Client Views (OoBDev.Web)
- **Issue**: Using `System.Diagnostics.Contracts` namespace
- **Required**: `OoBDev.Web.Controllers`
- **Impact**: Low - Code Contracts are a .NET framework feature

#### 2. Global Namespace Violations

**MyRedirectionFactory.MyInfoCheck**
- **Location**: `OoBDev.Web.Controllers.MyRedirectionFactory.MyInfoCheck(RequestContext, String)`
- **Issue**: Method in Global namespace instead of `OoBDev.Web.Controllers`
- **Impact**: Medium - Breaks namespace organization

**MyInfoModule.Init**
- **Location**: `OoBDev.Web.Controllers.MyInfoModule.Init(HttpApplication)`
- **Issue**: HTTP module in Global namespace
- **Impact**: Medium - HTTP modules may require global scope

**AccountController.Recovering**
- **Location**: `OoBDev.Web.Controllers.AccountController.Recovering(RecoverModel, String)`
- **Issue**: Method in Global namespace
- **Impact**: Medium - Controller action not following namespace rules

### Recommendations

1. **Address Global Namespace Issues**: Refactor methods to comply with namespace requirements
2. **Review Code Contracts Usage**: Consider if Code Contracts are still needed (deprecated in modern .NET)
3. **Update Architecture Validation**: Periodically review and fix suppressed violations

## Project References

The architecture layer validation includes the following projects:

- `OoBDev.Admin.Models` - Admin-specific models
- `OoBDev.Web.Controllers` - MVC controllers
- `OoBDev.Web.Models` - View models and DTOs
- `OoBDev.Web.Mvc` - MVC extensions
- `OoBDev.Web` - Main web application

## Best Practices

### Layer Communication

1. **Downward Dependencies Only**: Layers can only depend on layers below them
2. **Interface-Based**: Use interfaces for cross-layer communication
3. **Avoid Circular References**: Never create circular dependencies between layers

### Namespace Organization

1. **Consistent Naming**: Follow namespace conventions strictly
2. **Logical Grouping**: Group related classes in appropriate namespaces
3. **Avoid Global Namespace**: Never use the global namespace

### Validation

1. **Build-Time Checks**: Architecture validation runs at build time
2. **Suppress Sparingly**: Only suppress violations with documented justification
3. **Technical Debt Tracking**: Track all suppressions as technical debt items

## Related Documentation

- [Use Cases](./use-cases.md) - Gateway use cases and workflows
- [Admin Layer Diagram](../admin/layering.md) - Admin module layering
- [Site Library Layer Diagram](../site-library/layering.md) - Site library layering
