# ☁️ High-Availability Auto-Scaling Web Infrastructure
**AWS | Cloud Architecture | DevOps | Security**

## 📌 Project Overview
This project demonstrates a professional-grade, self-healing cloud architecture. I designed and deployed a web application that automatically scales its capacity based on traffic demand and ensures zero downtime by distributing resources across multiple data centers (Availability Zones).

## 🏗️ Architecture Diagram
Below is the infrastructure map representing the "Diagram-as-Code" (Rendered via Mermaid):

```mermaid
graph TD
    User((User/Internet)) -->|HTTP:80| ALB[Application Load Balancer]
    
    subgraph VPC [Custom VPC: 10.0.0.0/16]
        subgraph AZ1 [AZ: eu-north-1a]
            direction TB
            PubSub1[Public Subnet]
            PriSub1[Private Subnet]
            EC2_A[Portfolio Server A]
        end
        
        subgraph AZ2 [AZ: eu-north-1b]
            direction TB
            PubSub2[Public Subnet]
            PriSub2[Private Subnet]
            EC2_B[Portfolio Server B]
        end
        
        ALB --> PubSub1
        ALB --> PubSub2
        PubSub1 --> EC2_A
        PubSub2 --> EC2_B
        
        subgraph ASG [Auto Scaling Group: Desired 2, Max 4]
            EC2_A
            EC2_B
        end
    end

    style VPC fill:#f5f5f5,stroke:#333,stroke-width:2px
    style ASG fill:#fff,stroke:#f66,stroke-dasharray: 5 5,stroke-width:2px
    style ALB fill:#232f3e,color:#fff
