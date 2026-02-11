#!/bin/bash
set -e

PROJECT="bizpharma-prod"
INSTANCE="bizpharma-instance"

echo "🔒 Starting Cloud SQL hardening for $INSTANCE..."

# Step 1: Backups
echo "✅ Step 1/5: Enabling automated backups..."
gcloud sql instances patch $INSTANCE \
  --backup-start-time=03:00 \
  --retained-backups-count=30 \
  --retained-transaction-log-days=7 \
  --project=$PROJECT

# Step 2: PITR
echo "✅ Step 2/5: Enabling point-in-time recovery..."
gcloud sql instances patch $INSTANCE \
  --enable-point-in-time-recovery \
  --project=$PROJECT

# Step 3: Storage Auto-Resize
echo "✅ Step 3/5: Enabling storage auto-resize..."
gcloud sql instances patch $INSTANCE \
  --storage-auto-increase \
  --storage-auto-increase-limit=100 \
  --project=$PROJECT

# Step 4: Deletion Protection
echo "✅ Step 4/5: Enabling deletion protection..."
gcloud sql instances patch $INSTANCE \
  --deletion-protection \
  --project=$PROJECT

# Step 5: SSL
echo "✅ Step 5/5: Requiring SSL/TLS..."
gcloud sql instances patch $INSTANCE \
  --require-ssl \
  --project=$PROJECT

echo "🎉 Basic hardening complete!"
echo "⚠️  Next: Set up Private IP manually (see Step 6 in implementation plan)"
