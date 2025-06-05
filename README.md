# ARK: Survival Ascended - Cloud Run Cluster

This project provides the necessary infrastructure to run a private ARK: Survival Ascended server cluster on Google Cloud Run. The servers are containerized for fast startup and easy management.

## Features

-   **Containerized Servers:** Each server runs in its own Docker container, ensuring a clean and isolated environment.
-   **Cloud Run Deployment:** Servers are deployed as services on Google Cloud Run, allowing for easy scaling and management.
-   **One Service per Map:** Each map in the cluster (e.g., The Island, Scorched Earth) runs as a separate service.

## Prerequisites

-   [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
-   [Docker](https://docs.docker.com/get-docker/)
-   [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Getting Started

1.  **Clone the repository:**

    ```bash
    git clone <repository-url>
    cd ark-server-cloud-run
    ```

2.  **Configure the environment:**

    -   Create a `.env` file based on the `.env.example` file and populate it with your desired server settings.

3.  **Build and deploy the servers:**

    -   Follow the instructions in the `docs/` directory to build the Docker images and deploy them to Google Cloud Run.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue. 