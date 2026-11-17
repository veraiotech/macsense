# Changelog

All notable changes will be documented here. Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); MacSense follows [Semantic Versioning](https://semver.org/).

## [1.0.0] — 2026-11-17

First public release. Signed with a Developer ID Application certificate and notarized by Apple — Gatekeeper opens it on first launch with no warning.

### Added

**Cleanup**
- Categories for system junk, user caches, trash, purgeable space, and developer caches — dedicated scanners for Xcode, Homebrew, Node and Docker plus a catalog covering 30+ tools (npm, Yarn, pnpm, Bun, pip, Poetry, Conda, Cargo, Go, NuGet, Maven, Gradle, Composer, SwiftPM, pub, Hex, Cabal, Coursier, ccache, Bazel, Vagrant, Terraform, Pulumi, AWS SAM, …)
- Scheduled Smart Scan — daily, weekly or monthly, with a notification when there is something to reclaim. Review only; it never cleans on its own.

**Storage**
- Bubble-map explorer over a multithreaded native scanner, with multi-select delete, large/old file finder and a by-media-type breakdown
- Cached snapshot revealed after 5–10 s on repeat scans — instant feel while the real scan continues in the background

**Applications**
- Installed-app inventory with combined on-disk size and one-click uninstall that finds leftover support files, caches, preferences and launch agents
- Unused Apps tab driven by Spotlight's last-used date, with 30 / 60 / 90 / 180-day thresholds
- Login-items audit across User and System scopes, including SMAppService registrations
- Per-match confidence grading, an allowlist gate that refuses sensitive paths, and an append-only uninstall log
- Optional permanent deletion mode for uninstalls (Trash remains the default)

**Performance**
- Live CPU, memory, disk, network, battery and thermal meters
- Top-processes table with kill action, LAN device scan, Wi-Fi and Ethernet diagnostics, public IP, DNS flush

**Across the app**
- Inline help: per-section guides, contextual tooltips and one-shot coach marks
- 9 languages — English, German, Spanish, French, Portuguese, Russian, Hindi, Bengali, Simplified Chinese — switchable without restart
- Sidebar status dots driven by section state
- Hero landing per section with an explicit-opt-in scan model — nothing scans automatically
- ESC and sidebar-tap dismissal for all inline modals

### Notes

- **Cleanup deletes permanently.** A cache sitting in the Trash still occupies the disk you are trying to reclaim. Uninstalls and Storage deletions move to the Trash and are restorable; Cleanup does not.
- MacSense asks for Full Disk Access only when you scan a path that needs it. Nothing is granted up front.
- Wi-Fi SSID and BSSID show as "—" unless macOS Location Services is granted to MacSense.
- Login items registered via SMAppService can only be toggled by their parent app or in System Settings → Login Items. MacSense boots out and disables their launchd jobs and reports what remains.

### Checksums

```
512423eca7f3dee41e73b983c0a98ef44ed9ff7b8018a41b562c36faee595464  MacSense-1.0.0.dmg
```
