Service Readiness Knowledge Document
This document tracks the "Golden Rule" configurations for the bizPharma backend and Data Connect synchronization across all environments.

[DEV] Local Development
Project ID: bizpharma-4e73a
Data Connect Service: bizpharma-service
Data Connect Connector: biz-pharma
Region: asia-south1
Endpoint: http://127.0.0.1:9399
API Version: v1beta (Emulator preference)
Auth Emulator: http://127.0.0.1:9099
[STAGING] Staging Environment
Project ID: bizpharma-staging
Data Connect Service: bizpharma-service (Project-bound)
Data Connect Connector: biz-pharma
Region: asia-south1
Endpoint: https://dataconnect.googleapis.com
API Version: v1
[PROD] Production Environment
Project ID: bizpharma-prod
Data Connect Service: bizpharma-service (Project-bound)
Data Connect Connector: biz-pharma
Region: asia-south1
Endpoint: https://dataconnect.googleapis.com
API Version: v1
Sync Rules
Never use hyphens in the Service ID unless explicitly configured in 

dataconnect.yaml
.
Environment Awareness: The backend uses @property logic in 

settings.py
 to automatically switch these values based on the ENV variable.
App Check: Must be enforced in Staging/Prod. Debug tokens are only for Dev.