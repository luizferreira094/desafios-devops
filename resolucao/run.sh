#!/bin/bash
minikube start
helm init
minikube addons enable ingress

helm install --name app-chart app-chart-0.1.0.tgz
