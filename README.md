# Authentication API

This is the auth service for the microservice app

## 🚀 CI/CD Workflow

The `.github/workflows/build.yml` file defines a GitHub Action that performs the following steps:

1. **Checkout the code**: Retrieves the source code from the `main` branch.
2. **Authenticate with GCP**: Uses a service account (`GCP_SA_CREDENTIALS`) to authenticate with Google Cloud.
3. **Set up GCP SDK**: Installs and configures the `gcloud` CLI.
4. **Configure Docker with Artifact Registry**: Allows Docker to push images to GCP’s container registry.
5. **Get GKE credentials**: Connects to the GKE cluster to run `kubectl` commands.
6. **Set image tag**: Generates a unique image tag per commit using the branch name and timestamp.
7. **Build Docker image**: Builds and tags the Docker image with both the generated tag and `latest`.
8. **Push the image**: Pushes both `latest` and timestamped tags to GCP's Artifact Registry.
9. **Update deployment on GKE**: If a deployment named `frontend` exists, it updates the container image for `frontend-container`.

---

## 📁 Project Structure

```
.
├── Dockerfile
├── Gopkg.lock
├── Gopkg.toml
├── LICENSE
├── main.go
├── README.md
├── tracing.go
└── user.go
└── .github/workflows/   # GitHub Actions workflows
```

---

## 🛠️ Requirements

To make the workflow run successfully, you need to set up the following in your GitHub repository:

### 🔐 Secrets

- `GCP_SA_CREDENTIALS`: JSON with credentials for a service account that has permissions for:
  - Artifact Registry
  - GKE (get-credentials and set image)
- `GCP_PROJECT`: Google Cloud project ID
- `GKE_CLUSTER`: Name of your GKE cluster

### ⚙️ Variables

- `GCP_ZONE`: Zone where the cluster is located (e.g. `us-central1`)
- `REGISTRY`: Artifact Registry repository name (e.g. `my-registry`)
- `IMAGE_NAME`: Name of the image to be built (e.g. `frontend`)

---

## 🐳 Docker

This project includes a `Dockerfile` that packages the app for production. Make sure the Dockerfile is properly configured for your production environment.

---

## 🖥️ Local Development

This part of the exercise is responsible for the users authentication.

- `POST /login` - takes a JSON and returns an access token

The JSON structure is:

```json
{
  "username": "admin",
  "password": "admin"
}
```

## Configuration

The service scans environment for variables:

- `AUTH_API_PORT` - the port the service takes.
- `USERS_API_ADDRESS` - base URL of [Users API](/users-api).
- `JWT_SECRET` - secret value for JWT token processing. Must be the same amongst all components.

## Initial data

Following users are hardcoded for you:

| Username | Password |
| -------- | -------- |
| admin    | admin    |
| johnd    | foo      |
| janed    | ddd      |

## Building

```
- export GO111MODULE=on
- go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
- go mod tidy
- go build
```

## Running

```
 JWT_SECRET=PRFT AUTH_API_PORT=8000 USERS_API_ADDRESS=http://127.0.0.1:8083 ./auth-api
```

## Usage

In case you need to test this API, you can use it as follows:

```
 curl -X POST  http://127.0.0.1:8000/login -d '{"username": "admin","password": "admin"}'
```

## Dependencies

Here you can find the software required to run this microservice, as well as the version we have tested.
| Dependency | Version |
|-------------|----------|
| Go | 1.18.2 |
