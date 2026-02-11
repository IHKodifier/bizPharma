# Knowledge Base: Lessons Learned (Product Catalog Phase 2)

**Session Date:** Jan 2026
**Topic:** Schema Evolution, Data Connect Quirks, and Debugging Workflows

## 1. Schema Modifications & Ripple Effects

Modifying a core data type (like converting [Category](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/inventory/data/product_service.dart#85-113) from an **Enum** to a **Table**) is a high-impact change that touches every layer of the stack. It is not a localized edit.

### The "Category" Migration Checklist
When we changed [Category](file:///e:/Non_Office/Dev_Space/vibe_skool/bizPharma/lib/features/inventory/data/product_service.dart#85-113) from a static Enum to a dynamic Table, we had to update:

1.  **Schema Definitions (`dataconnect/schema/`)**:
    *   **Deleted**: `enums.gql` (Removed the `Category` enum).
    *   **Created**: `products/category.gql` (Defined the new `Category` table).
    *   **Updated**: `products/product.gql` (Changed `category` field from `Category` type to a relation, added `categoryId: UUID`).

2.  **Connector Operations (`dataconnect/connector/`)**:
    *   **Mutations**: `create_product.gql` signature changed. Instead of accepting a `Category` enum string (e.g., "VITAMINS"), it now requires a `categoryId` UUID.
    *   **Queries**: `list_products.gql` could no longer simply request `category`. It had to expand the selection set to `category { id name description }`.

3.  **Client Logic (`lib/...`)**:
    *   **Service Layer (`ProductService.dart`)**: The `createProduct` method signature changed to accept `categoryId` (String) instead of `Category` (Enum).
    *   **UI Layer (`AddProductPage.dart`)**:
        *   **Dynamic Loading**: The dropdown/selector could no longer be hardcoded from an Enum. It had to fetch data asynchronously via `listCategoriesByBusiness`.
        *   **Creation Flow**: We added a feature to "Create New Category" on the fly, necessitating a new Dialog and a new Mutation call.

### Lesson Verified
**"Schema changes are full-stack changes."** Always grep the codebase for the field name before modifying the schema to estimate the blast radius.

---

## 2. The JSONB Trap

We encountered a persistent "Cannot prepare SQL statement" error when trying to save a Category.

### The Problem
*   **Schema**: `metadata: String @col(dataType: "jsonb")`
*   **Input**: The client sent a simple String (or null).
*   **Error**: `column "metadata" is of type jsonb but expression is of type text`.

Data Connect (and the underlying Postgres driver) is strict. It does not automatically cast a String input to JSONB, even if the string contains valid JSON. It treats the input as text, causing a type mismatch at the SQL preparation level.

### The Solution
We changed the column type to **Text**:
*   **Revised Schema**: `metadata: String @col(dataType: "text")`

### Recommendation
Avoid `@col(dataType: "jsonb")` unless you strictly need to query *inside* the JSON document using SQL (e.g., `WHERE metadata->>'key' = 'value'`).
*   **Best Practice**: Store metadata as `text` in the database.
*   **Client-Side**: Serialize your Map/Object to a JSON string in Dart before sending. Deserialize it back to a Map when reading. This drastically reduces complexity and type errors.

---

## 3. UUID Formatting Quirks

We faced a `400 Bad Request` that gave no useful details on the client side.

### The Problem
*   **Input**: A "compact" UUID without dashes: `d0b327364fdf45829f31dc200e778bcf`.
*   **Requirement**: Data Connect (Postgres `uuid` type) expects the standard 8-4-4-4-12 format: `d0b32736-4fdf-4582-9f31-dc200e778bcf`.
*   **Result**: The request failed validation silently or with a generic error.

### The Fix
We implemented a helper function `_fixUuid(String id)` in `ProductService.dart` to detect connection-less strings (length 32) and insert the dashes before sending to the emulator.

### Lesson Verified
**"Trust, but Verify (and Format) your IDs."** Never assume the ID returned by one system (e.g., Auth, older DBs) matches the strict format required by another (Postgres). Always normalize UUIDs at the service boundary.

---

## 4. Debugging Strategy (The "Log" Rule)

When the Flutter client reports:
*   `400 Bad Request`
*   `RPC Error: FailedPrecondition`

**Do NOT guess.**
These generic client errors mask the true database rejection.

**Action**:
1.  Stop looking at the Flutter console.
2.  Open `firebase-debug.log` (or the Terminal running the emulator).
3.  Search for `SQL Error` or `Linker Error`.
    *   *Real Error found in this session:* `pq: unexpected message 'E'; expected ReadyForQuery` ... `column "metadata" is of type jsonb`.

---

## Summary Checklist for Future Features
If a new feature requires a schema change:
1.  [ ] **Audit**: Where is this field used? (Mutations, Queries, Dart Models, UI Forms).
2.  [ ] **Type Check**: Are we using `jsonb`? If so, switch to `text` unless purely necessary.
3.  [ ] **ID Check**: Are we passing UUIDs? Ensure the client normalizes them to `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`.
4.  [ ] **Log Check**: If it fails, check the *Server* logs immediately.

---

## 5. The "Fake Schema" Fallacy (Strictness in Emulators)

We encountered confusion where the environment felt "fake" (local emulator, public auth) but the errors were real and strict.

### The Misconception
**"It's just a local emulator with `@auth(level: PUBLIC)`, so it should be permissive."**
We assumed that since we relaxed security, the system would also relax data validation.

### The Reality
The Data Connect Emulator is backed by a **real** instances of Postgres. It does **not** loosen data integrity rules just because it's running locally.
1.  **Strict UUIDs**: Even in dev, Postgres rejects 32-character hex strings for `UUID` columns. They **must** be 36-characters with dashes (`8-4-4-4-12`).
2.  **Strict Types**: You cannot shove a `String` into a `JSONB` column without casting. The emulator doesn't "guess" your intent.

### The "Silent Failure" in UI
**Issue**: "The product saving dialog disappeared... not sure if it was saved."
**Cause**:
*   The `await` call in the UI layer completed (or failed) and the code proceeded to close the dialog (`Navigator.pop`).
*   If a `try/catch` block suppresses the error (printing it only to console) and then allows execution to continue, the dialog closes as if successful.
**Lesson**:
*   **Always Rethrow or Show Feedback**: In the Service layer, `rethrow` errors so the UI knows it failed.
*   **UI Feedback**: The UI must *only* close the dialog if the `await` succeeds. If it catches an error, it should keep the dialog open and show a `SnackBar` or `AlertDialog` with the error message.

