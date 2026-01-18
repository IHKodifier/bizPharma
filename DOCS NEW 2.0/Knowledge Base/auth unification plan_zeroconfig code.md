Auth Unification Plan: Zero-Config Code
Goal: Enable @auth(level: USER) in all 
.gql
 files and have it work seamlessly across Dev, Staging, and Production without code changes.

The Strategy
The "Code Parity" principle states that your application code (including Data Connect queries) must be identical across environments. If it fails in Staging but works in Dev, the issue is Environment Configuration, not Code.

We will fix the Staging Environment (and by extension Production) to accept valid Firebase Auth tokens.

Phase 1: Environment Diagnostic (Immediate)
We must confirm why the token is being rejected. It is usually one of two reasons:

Identity Mismatch: The App is generating a token for Project A, but sending it to Data Connect in Project B.
Missing IAM Role: The Staging Project lacks the permission link between Firebase Auth and Data Connect.
Action Item 1.1: Log Token Details
Add this temporary log in 
lib/services/location_service.dart
 (inside 
createLocation
 or 