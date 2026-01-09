# 002. Preferences with UserDefaults and PNG Export

Date: 2026-01-09

## Status

Accepted

## Context

The app needed user preferences for customizing output format (PDF vs PNG) and a way to persist these settings across app restarts. Additionally, PNG export required a rendering approach that produces high-quality images suitable for various use cases.

## Decision

1. **UserDefaults for persistence**: Use `UserDefaults.standard` directly via a singleton `Preferences` class rather than SwiftUI's `@AppStorage` property wrapper to ensure compatibility across all entry points (FinderSync extension, Services handler, Action extension).

2. **Singleton pattern**: `Preferences.shared` provides global access to settings from any component without dependency injection complexity.

3. **2x Retina rendering for PNG**: Render PDF pages at 2x scale (144 DPI effective) to produce crisp images on Retina displays while keeping file sizes reasonable.

4. **CGContext-based rendering**: Use Core Graphics directly (`CGContext`) for PNG rendering rather than PDFKit's thumbnail API for full control over quality, color space (sRGB), and background handling.

## Consequences

### Positive

- Settings persist reliably across app restarts
- All entry points (Finder, Services, Quick Actions) share the same preferences
- PNG output is high quality and consistent across different PDF content
- Simple implementation with minimal code

### Negative

- UserDefaults doesn't sync across devices (iCloud sync would require additional work)
- 2x rendering doubles memory usage during PNG export
- No migration path if settings schema changes (would need manual migration)

## Alternatives Considered

1. **@AppStorage in SwiftUI**: Rejected because FinderSync extension doesn't have SwiftUI context and needs shared access to preferences.

2. **Property list file**: Rejected as UserDefaults provides the same persistence with less boilerplate.

3. **PDFPage.thumbnail(of:for:)**: Rejected because it doesn't provide sufficient control over rendering quality and color space.

4. **1x rendering**: Rejected as images appear blurry on Retina displays.

## Related

- Planning: `.plan/.done/feat-error-handling-and-preferences/`
