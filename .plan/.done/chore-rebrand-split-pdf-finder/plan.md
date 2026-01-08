# Rebrand to "Split PDF (Finder)"

## Scope

Rebrand the app display name and user-facing text to "Split PDF (Finder)" while preserving internal structure.

## Decisions (Locked)

| Item | Decision | Rationale |
|------|----------|-----------|
| Bundle ID | Keep `com.splitpdf.app` | Stability > branding; users never see it |
| Context menu | Keep "Split into Pages" | Actions stay verb-focused, not branded |
| Project folders | Keep `SplitPDF/` | No revenue impact; avoids git noise |
| Notification title | Use "Split PDF (Finder)" | Visible polish point; builds trust |
| Display names | Update to "Split PDF (Finder)" | User-facing in System Settings |

## Files to Update

1. `README.md` - Title and subtitle
2. `SplitPDF/Shared/PDFSplitter.swift:85` - Notification title
3. `SplitPDF/SplitPDFExtension/Info.plist` - CFBundleDisplayName
4. `SplitPDF/SplitPDFAction/Info.plist` - CFBundleDisplayName

## Files NOT Changed (Intentionally)

- `project.yml` - Internal project name stays "SplitPDF"
- `SplitPDF/SplitPDF/Info.plist` - NSPortName stays "SplitPDF" (internal)
- Bundle identifiers - Stability concern
- Swift struct names - Internal code
