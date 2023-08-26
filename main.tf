terraform {
  backend "s3" {
    dynamodb_table = "peak-terraform"
    encrypt        = true
    region = var.region
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.60.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
    kafka = {
      source = "Mongey/kafka"
    }
  }
}

### Providers ###
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      stage            = local.stage
      tenant           = "platform"
      feature          = "ingestion"
      service          = local.service_name
      VantaOwner       = "atul.sharma@peak.ai"
      VantaDescription = "PeakAI-Infrastructure"
      VantaNonProd     = (local.stage == "prod" || local.stage == "parvati") ? false : true
    }
  }
}

resource "aws_sqs_queue" "service_queues" {
  name = "safwan-queue-${local.stage}"
}

locals {
    stage        = terraform.workspace
    service_name = var.service_name
}
