#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "ap-northeast-1"
    }
    stages {
        stage("clearing existing an EKS Cluster") {
            steps {
                script {
                    dir('eks-cluster') {
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('eks-cluster') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name eks-cluster --region ap-northeast-1"
                        sh "cat /var/lib/jenkins/.kube/config"
                        sh "kubectl apply -f dep_db_pv.yaml -n default"
                        sh "kubectl apply -f dep_db.yaml -n default"
                        sh "kubectl apply -f dep_app.yaml -n default"
                        sh "kubectl apply -f dep_test.yaml -n default"
                    }
                }
            }
        }
    }
}