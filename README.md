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
    -   Create a Google Cloud Storage (GCS) bucket to store the shared cluster data.
    -   Update the `GCS_BUCKET_NAME` in your `.env` file with the name of your bucket.
    -   Set a unique `CLUSTER_ID` in your `.env` file.

3.  **Build and deploy the servers:**

    -   Follow the instructions in the `docs/` directory to build the Docker images and deploy them to Google Cloud Run.
    -   To deploy all maps defined in `deploy_all.sh`, run:
        ```bash
        bash ./deploy_all.sh
        ```
    -   To deploy a single map, run:
        ```bash
        bash ./build.sh <map-name>
        bash ./deploy.sh <map-name>
        ```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue. 