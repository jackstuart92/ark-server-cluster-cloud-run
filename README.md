# ARK: Survival Evolved Server Cluster on Google Cloud Run

This project provides the necessary files to build and deploy an ARK: Survival Evolved server cluster on Google Cloud Run using Docker.

## Security Recommendations

Running a public-facing game server can expose you to various security risks. It's crucial to implement a robust security posture to protect your server and players.

### 1. Firewall Configuration

Your first line of defense is a properly configured firewall. By default, you should deny all incoming traffic and only allow connections to the specific ports required by the ARK server.

**Required Ports:**
*   **7777/udp**: Game client traffic
*   **7778/udp**: Raw UDP socket for server queries
*   **27015/udp**: Steam query port
*   **27020/tcp**: RCON (Remote Console) for server administration

Since you are deploying on Google Cloud, you can use [VPC firewall rules](https://cloud.google.com/vpc/docs/firewalls) to secure your instances.

**Example `gcloud` commands to set up firewall rules:**

```bash
# Allow ARK game traffic
gcloud compute firewall-rules create ark-game-traffic --allow udp:7777-7778 --description "Allow ARK game client and query traffic" --target-tags ark-server

# Allow Steam query traffic
gcloud compute firewall-rules create ark-steam-query --allow udp:27015 --description "Allow Steam server query traffic" --target-tags ark-server

# Restrict RCON access to your IP address
gcloud compute firewall-rules create ark-rcon-access --allow tcp:27020 --source-ranges YOUR_IP_ADDRESS/32 --description "Allow RCON access from a specific IP" --target-tags ark-server
```
*Remember to replace `YOUR_IP_ADDRESS` with your actual public IP address.*

### 2. DDoS Protection

Game servers are a common target for Distributed Denial of Service (DDoS) attacks. These attacks can overwhelm your server with traffic, making it inaccessible to legitimate players.

[Google Cloud Armor](https://cloud.google.com/armor) is a managed DDoS protection service that can help mitigate these attacks. It's highly recommended to configure Cloud Armor for your deployment.

### 3. Strong Passwords

Ensure you use strong, unique passwords for both the in-game admin account and the RCON protocol. A weak password can be easily guessed, giving an attacker full control over your server.

## Managing Environment Variables and the `.env` file

This project uses a `.env` file to manage sensitive information such as server passwords, API keys, and other secrets.

**⚠️ DANGER: DO NOT COMMIT YOUR `.env` FILE TO GITHUB ⚠️**

Your `.env` file will contain highly sensitive credentials. If you commit this file to a public repository, you are exposing these secrets to the world. This could lead to:

*   **Server Hijacking**: Attackers can use your RCON password to take control of your server.
*   **Financial Loss**: If you store billing or API keys in your `.env` file, attackers could use them to run up costs on your cloud account.
*   **Reputation Damage**: A compromised server can be used for malicious purposes, harming your community's reputation.

The `.gitignore` file in this repository is already configured to ignore `.env` files, but you should always be vigilant.

### How to Use `.env.example`

1.  Make a copy of the `.env.example` file and name it `.env`.
    ```bash
    cp .env.example .env
    ```
2.  Open the new `.env` file and fill in the required values.
3.  Your application will load these variables at runtime. This keeps your secrets safe and out of version control.

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