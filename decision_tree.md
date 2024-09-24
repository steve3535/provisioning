```mermaid
graph TD
   A[User] --> B[VM Input Portal]
   B --> C[DOMAIN=LAN]
   B --> D[DOMAIN=DMZ]
   C --> E[DC=DC1]
   C --> F[DC=DC3]
   D --> G[DC=DMZDC01]
   D --> H[DC=DMZDC02]
```
