# OoBDev Gateway Architecture

The Gateway is the core application that provides authentication, authorization, and common services for the OoBDev clinical trial management system.

## Architecture Diagrams

- [Use Cases](./use-cases.md) - User interactions and system use cases
- [Layering](./layering.md) - Layered architecture and dependencies
- [SAE Use Cases](./sae-use-cases.md) - Safety Adverse Event management

## Overview

The Gateway application provides:

- **Authentication & Authorization** - User login, password management, role-based access
- **User Management** - Self-registration, profile management, trial/site assignments
- **System Services** - Exception logging, email queue processing
- **SAE Management** - Safety Adverse Event case management and medical review workflow

## Key Components

### Architectural Layers

1. **Client Views** - MVC Controllers and presentation logic
2. **Service Model** - Business logic and service orchestration
3. **Business Model** - Domain models and business entities
4. **MVC Extensions** - Custom ASP.NET MVC extensions
5. **Data Access** - Repository pattern and data access logic
6. **Data Persistence** - Database and ORM layer

### Actor Roles

- **Gateway User** - Base user with login and profile management capabilities
- **Trial/Site Manager** - Extends Gateway User with trial and site management
- **Coordinator (RA1)** - Research Assistant level 1 for SAE case creation
- **Manager (RA2)** - Research Assistant level 2 for SAE review and submission
- **Server** - System actor for automated processes
- **Email Processor** - Automated email handling through message queues

## Architecture Validation

The Gateway enforces strict layered architecture rules with namespace restrictions. Architecture violations are tracked in the layer diagram suppressions file.

## Related Documentation

- [Admin Architecture](../admin/README.md)
- [Messaging Architecture](../messaging/README.md)
- [CEC Architecture](../cec/README.md)
