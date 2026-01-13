# OoBDev Admin Architecture

The Admin module provides system administration capabilities for managing users, roles, and trial configurations in the OoBDev clinical trial management system.

## Architecture Diagrams

- [Use Cases](./use-cases.md) - Administrative use cases
- [Layering](./layering.md) - Admin module layered architecture

## Overview

The Admin module provides administrative functions for:

- **User Management** - Create, list, and modify user accounts
- **Password Management** - Reset passwords and unlock accounts
- **Role Assignment** - Assign and manage user roles
- **Bulk Operations** - Import users in bulk
- **Trial Configuration** - Configure trial settings and properties

## Key Components

### Architectural Layers

1. **Admin Client** (`OoBDev.Admin.Controllers`) - MVC controllers for admin operations
2. **Admin Models** (`OoBDev.Admin.Models`) - Data models and view models
3. **Admin Access** (`OoBDev.Admin.Access`) - Data access layer for admin operations

### Actor Roles

- **Gateway Admin** - System administrator with full administrative privileges

## Related Documentation

- [Gateway Architecture](../gateway/README.md) - Core Gateway functionality
- [Messaging Architecture](../messaging/README.md) - System messaging and notifications
