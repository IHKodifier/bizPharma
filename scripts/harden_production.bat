@echo off
REM Production Cloud SQL Hardening Script for Windows
REM Run this in Command Prompt (cmd.exe)

set PROJECT=bizpharma-prod
set INSTANCE=bizpharma-instance

echo Starting Cloud SQL hardening for %INSTANCE%...

REM Step 1: Backups
echo Step 1/5: Enabling automated backups...
cmd /c "gcloud sql instances patch %INSTANCE% --backup-start-time=03:00 --retained-backups-count=30 --retained-transaction-log-days=7 --project=%PROJECT%"

REM Step 2: PITR
echo Step 2/5: Enabling point-in-time recovery...
cmd /c "gcloud sql instances patch %INSTANCE% --enable-point-in-time-recovery --project=%PROJECT%"

REM Step 3: Storage Auto-Resize
echo Step 3/5: Enabling storage auto-resize...
cmd /c "gcloud sql instances patch %INSTANCE% --storage-auto-increase --storage-auto-increase-limit=100 --project=%PROJECT%"

REM Step 4: Deletion Protection
echo Step 4/5: Enabling deletion protection...
cmd /c "gcloud sql instances patch %INSTANCE% --deletion-protection --project=%PROJECT%"

REM Step 5: SSL
echo Step 5/5: Requiring SSL/TLS...
cmd /c "gcloud sql instances patch %INSTANCE% --require-ssl --project=%PROJECT%"

echo.
echo Basic hardening complete!
echo Next: Set up Private IP manually (see implementation plan)
pause
