#!/bin/bash

# Script to set up Git hooks for this repository

echo "Setting up Git hooks..."

# Make sure hooks are executable
chmod +x .githooks/*

# Configure Git to use the .githooks directory
git config core.hooksPath .githooks

echo "Git hooks installed successfully!"
