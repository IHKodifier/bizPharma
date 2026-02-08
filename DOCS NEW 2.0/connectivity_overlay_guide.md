# Connectivity Overlay - Quick Reference

## Current Status ✅

**Feature Flag:** `FeatureFlags.showConnectivityOverlay` in `lib/config/feature_flags.dart`

**Default Behavior:**
- 🟢 **Local Debug:** Auto-enabled
- 🔴 **Production:** Auto-disabled (release build)
- 🔴 **Staging:** Auto-disabled (release build)

---

## Enable Overlay in Staging

### Option 1: Permanent (Update GitHub Actions)

**File:** `.github/workflows/deploy.yml` (lines 40-41)

**Replace:**
```yaml
- name: Build Web App
  run: flutter build web --release --dart-define=ENVIRONMENT=${{ env.BUILD_ENV }}
```

**With:**
```yaml
- name: Build Web App
  run: |
    if [[ "${{ env.BUILD_ENV }}" == "staging" ]]; then
      flutter build web --release \
        --dart-define=ENVIRONMENT=${{ env.BUILD_ENV }} \
        --dart-define=SHOW_CONNECTIVITY_OVERLAY=true
    else
      flutter build web --release \
        --dart-define=ENVIRONMENT=${{ env.BUILD_ENV }}
    fi
```

**Result:** Overlay shows on every staging deployment

---

### Option 2: One-Time (Manual Deployment)

```bash
# Build with overlay enabled
flutter build web --release \
  --dart-define=ENVIRONMENT=staging \
  --dart-define=SHOW_CONNECTIVITY_OVERLAY=true

# Deploy to staging
firebase deploy --only hosting --project bizpharma-staging
```

**Result:** Overlay shows until next automated deployment

---

## Production Safety ✅

**No action needed!** The overlay is automatically disabled in production release builds.

The `defaultValue: kDebugMode` ensures it never appears in production.
