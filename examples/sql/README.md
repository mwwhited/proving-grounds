# SQL Database Utilities Collection

Collection of SQL Server and PostgreSQL utility scripts for database introspection, schema export, and code generation.

---

## Schema Export & Documentation

Scripts for exporting database schema information in various formats.

### SchemaExportBasic.sql
**Purpose:** Basic schema export to XML
**Database:** SQL Server
**Output:** XML representation of database schema
**Description:**
Exports database schema including:
- Schemas
- Tables
- Columns with data types
- Nullable flags
- Full type specifications (length, precision, scale)

**Output Format:** XML (`<schema>` elements with nested `<table>` and `<column>` nodes)

**Usage Example:**
```sql
USE [your_database];
GO
-- Run script to get XML schema export
```

---

### SchemaExportWithRelationships.sql
**Purpose:** Comprehensive schema export with relationships
**Database:** SQL Server
**Output:** Detailed XML with tables, indexes, and foreign keys
**Description:**
Complete database schema export including:
- Tables and columns
- Indexes (primary keys, unique indexes, clustered/non-clustered)
- Foreign key relationships
- Column references for keys

**Output Format:** XML (`<db>` root with nested `<schema>`, `<table>`, `<index>`, `<foreign-key>` elements)

**Key Features:**
- Excludes `sysdiagrams` system table
- Includes full index definitions
- Maps foreign key columns between tables

---

### SchemaExportExtended.sql
**Purpose:** Extended schema export with metadata
**Database:** SQL Server
**Output:** Schema export with extended properties and ordinals
**Description:**
Enhanced version of SchemaExportWithRelationships.sql adding:
- Extended properties (custom metadata)
- Ordinal positions (ROW_NUMBER)
- Additional schema metadata

---

### TableRelationshipExport.sql
**Purpose:** Table relationship mapping
**Database:** SQL Server
**Output:** XML of table relationships
**Description:**
Analyzes and exports table relationships including:
- Primary keys with column details
- Foreign key relationships
- Referenced tables and columns
- Relationship cardinality

**Output Format:** XML (`<tables>` root with relationship mappings)

---

## Metadata & Introspection

Scripts for analyzing database objects and metadata.

### DatabaseObjectCatalog.sql
**Purpose:** Database object catalog
**Database:** SQL Server
**Output:** Tabular list of all database objects
**Description:**
Comprehensive scan of database objects:
- Tables, views, stored procedures, functions
- Object types and descriptions
- Schema organization
- Column metadata (type, length, precision, scale, collation)

**Key Features:**
- Excludes Microsoft-shipped objects (`is_ms_shipped = 0`)
- Handles parent-child object relationships
- Shows object hierarchy

**Use Case:** Database documentation, object inventory, migration planning

---

### SqlToCSharpGenerator.sql
**Purpose:** SQL to C# type mapping and code generation
**Database:** SQL Server
**Output:** C# property definitions from table/view columns
**Description:**
Generates C# POCO properties from database objects:
- Maps SQL types → C# types
- Handles nullable types (`Nullable<T>` syntax)
- Generates property declarations

**Example Output:**
```csharp
public string name { get; set; }
public int? quantity { get; set; }
public DateTime created_date { get; set; }
```

**Configuration:**
- Modify `@procName` variable to target table/view
- Currently set to `[dbo].[YourTableOrViewName]`

**Type Mappings:**
- `varchar/nvarchar` → `string`
- `datetime/datetime2` → `DateTime`
- `money` → `decimal`
- `bit` → `bool`
- `tinyint` → `byte`
- `smallint` → `short`

---

## SQL Server Specific

Scripts for SQL Server system databases and features.

### SqlAgentJobExport.sql
**Purpose:** SQL Server Agent job monitoring
**Database:** SQL Server (`msdb`)
**Output:** XML document of job configurations and history
**Description:**
Comprehensive export of SQL Server Agent jobs including:
- Job definitions (name, enabled status, description)
- Schedule information (next run date/time)
- Execution activity and history
- Job steps with commands and logs
- Success/failure tracking

**Output Format:** XML with nested `<steps>` and `<histories>` elements

**Use Cases:**
- Job documentation
- Migration planning
- Performance analysis
- Troubleshooting job failures

---

### SsisPackageInventory.sql
**Purpose:** SSIS package inventory
**Database:** SQL Server (`msdb`)
**Output:** Latest version of each SSIS package
**Description:**
Retrieves SSIS package metadata from msdb:
- Package names and IDs
- Version information
- Descriptions
- Owner information
- Creation dates
- Package types

**Key Feature:** Uses CTE to filter only the latest version of each package by creation date.

---

### ServiceBrokerMessageTypeGenerator.sql
**Purpose:** SQL Server Service Broker message type generator
**Database:** SQL Server (any database with XML schema collections)
**Output:** `CREATE MESSAGE TYPE` statements
**Description:**
Generates Service Broker message type definitions from XML schema collections:
- Extracts XML schemas
- Maps to Service Broker namespaces
- Creates validation statements

**Example Output:**
```sql
CREATE MESSAGE TYPE [namespace_name]
 AUTHORIZATION [dbo]
 VALIDATION = VALID_XML WITH SCHEMA COLLECTION [schema].[collection_name]
```

**Use Case:** Automating Service Broker setup from existing XML schemas

---

## PostgreSQL

Scripts for PostgreSQL event log analysis.

### PostgresEventLogQuery.sql
**Purpose:** Event trace log query
**Database:** PostgreSQL (event logging database)
**Output:** Event log entries
**Description:**
Queries application event traces with JSON payload filtering:
- Event source filtering (`NgxEventSource`)
- Computer/hostname filtering
- JSON payload extraction
- Time range filtering

**Note:** Hostname filters are provided as examples and should be customized for your environment.

**PostgreSQL Features:**
- JSON operators (`::JSON`, `->`)
- `LIMIT` clause
- `lower()` function on text casts

---

## Code Generation

Scripts that generate SQL or code from metadata.

### XmlExportStatementGenerator.sql
**Purpose:** XML export statement generator
**Database:** SQL Server (any database)
**Output:** Generated SELECT statements
**Description:**
Generates `SELECT ... FOR XML AUTO` statements for all tables in the database.

**Example Output:**
```sql
,(SELECT * FROM [dbo].[customers] FOR XML AUTO, TYPE)
,(SELECT * FROM [dbo].[orders] FOR XML AUTO, TYPE)
```

**Use Case:**
- Quick data export script generation
- Building complete database XML dumps
- Creating data migration scripts

---

## Experimental / Archive

Scripts that are incomplete, experimental, or deprecated.

### XmlModificationExperiment.sql
**Purpose:** XML modification experiment
**Database:** SQL Server
**Status:** ⚠️ Experimental/Abandoned
**Description:**
Attempted XML manipulation using:
- Cursors to iterate over attribute data
- `xml.modify()` method
- Dynamic XPath expressions
- Attribute insertion into XML

**Issues:**
- Cursor-based approach (performance anti-pattern)
- Commented-out code suggests debugging/troubleshooting
- May not work as intended

**Learning Value:** Demonstrates SQL Server XML manipulation techniques (even if flawed)

---

## Quick Reference

| Script | Database | Purpose | Output |
|:-------|:---------|:--------|:-------|
| SchemaExportBasic.sql | SQL Server | Basic schema export | XML |
| SchemaExportWithRelationships.sql | SQL Server | Schema + relationships | XML |
| SchemaExportExtended.sql | SQL Server | Schema + extended props | XML |
| TableRelationshipExport.sql | SQL Server | Table relationships | XML |
| DatabaseObjectCatalog.sql | SQL Server | Object catalog | Tabular |
| SqlToCSharpGenerator.sql | SQL Server | C# code generation | C# properties |
| SqlAgentJobExport.sql | SQL Server | Agent jobs | XML |
| SsisPackageInventory.sql | SQL Server | SSIS packages | Tabular |
| ServiceBrokerMessageTypeGenerator.sql | SQL Server | Service Broker generator | SQL |
| PostgresEventLogQuery.sql | **PostgreSQL** | Event log query | Tabular |
| XmlExportStatementGenerator.sql | SQL Server | Export generator | SQL |
| XmlModificationExperiment.sql | SQL Server | XML experiment | ⚠️ Experimental |

---

## Security Considerations

Before using these scripts in production:

1. **Database Names:**
   - Scripts use placeholder `[YourDatabaseName]` in commented-out `USE` statements
   - Uncomment and replace with your actual database name

2. **Permissions:**
   - Schema queries require `VIEW DEFINITION` permission
   - Agent queries require access to `msdb`
   - Extended properties require elevated permissions

3. **Environment-Specific Data:**
   - PostgresEventLogQuery.sql contains example hostname filters - customize for your environment

---

## Common Use Cases

### Database Migration
Use SchemaExportWithRelationships.sql and TableRelationshipExport.sql to document schema and relationships before migration.

### Code Generation
Use SqlToCSharpGenerator.sql to generate C# POCOs from database tables for ORM mapping.

### Documentation
Use DatabaseObjectCatalog.sql to create comprehensive database object inventory.

### Monitoring
Use SqlAgentJobExport.sql to monitor and document SQL Server Agent jobs.

### Service Broker Setup
Use ServiceBrokerMessageTypeGenerator.sql to generate message types from XML schemas.

---

*Part of the proving-grounds repository - SQL utilities collection*
