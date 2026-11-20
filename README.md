# SmartPay Demo — Android Cloud Build

This is a demonstration wallet UI only. It does not perform real deposits, withdrawals, payments, or transfers.

## Upload from a phone
1. Download and extract this ZIP on your phone.
2. Open https://github.com/Alamin4351/smartpay-demo
3. Choose **Add file → Upload files** and upload the extracted project contents (not the outer folder).
4. Ensure the hidden `.github/workflows/android-apk.yml` file is included. If Android file picker hides `.github`, use GitHub in Chrome with **Desktop site** enabled, or create the workflow file in GitHub's web editor at `.github/workflows/android-apk.yml` and paste its contents from this ZIP.
5. Commit to `main`.
6. Open the repository's **Actions** tab. Select **Build SmartPay Android APK** and run it if it has not started automatically.
7. When the run completes successfully, open it and download the `smartpay-android-apk` artifact. Extract it; install `app-release.apk`.

## Safety and production
Do not enter real PINs, OTPs, card details, or banking credentials. A production financial service needs the relevant Bangladesh regulatory approvals/authorized-provider arrangements, secure server-side ledger, compliance controls, and independent security testing. This demo is not suitable for real funds.
