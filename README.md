# ND9991 - Course 2 - Infrastructure as Code

This repository contains the starter code for the final project of course 2 Infrastructure as Code in the Cloud DevOps Engineer Nanodegree.

Please note that all supporting material for this course can be found in [this Github repository](https://github.com/udacity/cd12352-Deploy-Infrastructure-as-Code).

# Deploy a high-availability web app using CloudFormation

In this project, you’ll deploy web servers for a highly available web app using CloudFormation. You will write the code that creates and deploys the infrastructure and application for an Instagram-like app from the ground up. You will begin with deploying the networking components, followed by servers, security roles and software.  The procedure you follow here will become part of your portfolio of cloud projects. You’ll do it exactly as it’s done on the job - following best practices and scripting as much as possible. 

## Getting Started

### Dependencies

1. AWS CLI installed and configured in your workspace using an AWS IAM role with Administrator permissions (as reviewed in the course).

2. Access to a diagram creator software of your choice.

3. Your favorite IDE or text editor ready to work.

### Installation

You can get started by cloning this repo in your local workspace:

```
git clone git@github.com:udacity/-cd12352-Deploy-Infrastructure-as-Code-project.git
```

## Testing

No tests required for this project.

## Project Instructions

1. Design your solution diagram using a tool of your choice and export it into an image file.

2. Add all the CloudFormation networking resources and parameters to the `network.yml` and `network-parameters.json` files inside the `starter` folder of this repo.

3. Add all the CloudFormation application resources and parameters to the `udagram.yml` and `udagram-parameters.json` files inside the `starter` folder of this repo.

4. Create any required script files to automate spin up and tear down of the CloudFormation stacks.

5. Update the README.md file in the `starter` folder with creation and deletion instructions, as well as any useful information regarding your solution.
   
6.  Submit your solution as a GitHub link or a zipped file containing the diagram image, CloudFormation yml and json files, automation scripts and README file.

## Diagram

```Mermaid
graph TB
    %% Internet Gateway and VPC
    Internet((Internet))
    subgraph VPC
        %% Load Balancer in Public Subnets
        subgraph "Public Subnets"
            ALB[Application Load Balancer]
            NAT1[NAT Gateway 1]
            NAT2[NAT Gateway 2]
            BASTION[Bastion Host]
        end

        %% EC2 instances in Private Subnets
        subgraph "Private Subnets"
            ASG[Auto Scaling Group]
            EC2_1[EC2 Instance 1]
            EC2_2[EC2 Instance 2]
            EC2_3[EC2 Instance 3]
            EC2_4[EC2 Instance 4]
        end
    end

    %% S3 and CloudFront
    S3[(S3 Bucket)]
    CDN[CloudFront]

    %% Connections
    Internet <--> IGW
    IGW <--> ALB
    ALB <--> EC2_1
    ALB <--> EC2_2
    ALB <--> EC2_3
    ALB <--> EC2_4
    Internet <--> CDN
    CDN <--> S3
    NAT1 <--> Internet
    NAT2 <--> Internet
    EC2_1 <--> NAT1
    EC2_2 <--> NAT1
    EC2_3 <--> NAT2
    EC2_4 <--> NAT2
    BASTION <--> Internet
    BASTION -.-> EC2_1
    BASTION -.-> EC2_2
    BASTION -.-> EC2_3
    BASTION -.-> EC2_4

    %% Styling
    classDef vpc fill:#f9f,stroke:#333,stroke-width:2px
    class VPC vpc
```

## License

[License](LICENSE.txt)
