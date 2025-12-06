## Tech_Stack:
* The frontend will be built in Flutter.
* **Firebase** infrastructure will power the backend.
* **Firebase Data Connect** will be used to connect to a PostgreSQL Database on the Cloud. 
* The authentication will use Firebase Authentication.(Google, Email and email/password)
* front-end will only and only talk to secured API endpoints(secured via rate limiting and tier based feature gating    ) for the app. no direct calls to back ernd auth or db
* The backend will be built in Python using FastAPI.
* I will use Firebase Analytics  For analytics in my application
* Multi-tenancy will be built into the app from the grounds up. The root of the multi-tenancy will be the business table in the DB. 
* subscriptions and payments  will be managed through paddle.com.
