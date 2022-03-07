#!/bin/bash
set -e

PROJECT="$(basename "$PWD")"
docker build -t "$PROJECT" --no-cache .
docker tag "$PROJECT" imsamurai/"$PROJECT"
docker push imsamurai/"$PROJECT"
