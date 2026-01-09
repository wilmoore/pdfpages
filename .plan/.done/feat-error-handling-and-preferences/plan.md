# Feature: Error Handling and Preferences

## Branch
`feat/error-handling-and-preferences`

## Scope

### Epic #4: Error Handling and Notifications (E-004)
User feedback through macOS notifications when PDF splitting fails due to corruption or password protection.

### Story #9: Error notification on split failure (US-004)
**Acceptance Criteria:**
- Given a corrupted or password-protected PDF
- When I attempt to split
- Then a macOS notification explains the failure
- And no output files are created

### Epic #5: Preferences and Output Options (E-005)
Optional preferences window allowing users to customize output format (PDF, PNG), output folder, and naming patterns.

### Story #10: Choose output format in preferences (US-005)
**Acceptance Criteria:**
- Given preferences are enabled
- When I select PNG output
- Then each page is exported as a PNG file

---

## Current State Analysis

### Existing Notification Infrastructure
The app already has a comprehensive notification system in `PDFSplitter.swift`:
- Uses `UNUserNotificationCenter`
- Requests permission on app launch
- Shows notifications for success, partial success, and failures
- Errors already handled: corruption, password-protection, empty PDFs, directory creation failures

**Assessment:** Story #9 is **already implemented**. The current implementation in `PDFSplitter.swift` (lines 73-96) covers all acceptance criteria.

### Missing Infrastructure
- No UserDefaults usage
- No preferences UI
- Settings scene in SplitPDFApp is empty
- All behavior is hard-coded

---

## Implementation Plan

### Phase 1: Verify Error Handling (Story #9)
1. Write e2e tests to verify error notifications work correctly
2. Test with corrupted PDF
3. Test with password-protected PDF
4. Verify no output files are created on failure

### Phase 2: Preferences Infrastructure (Epic #5)
1. Create `Preferences.swift` - UserDefaults wrapper for settings
2. Define settings model:
   - `outputFormat`: PDF (default) or PNG
   - `outputDirectory`: Custom path or same-as-source (default)
   - `namingPattern`: Template for output files

### Phase 3: Preferences UI (Epic #5)
1. Update `SplitPDFApp.swift` Settings scene with preferences window
2. Create SwiftUI preferences view with:
   - Output format picker (PDF/PNG)
   - Output directory selector
   - Naming pattern customization

### Phase 4: PNG Export Support (Story #10)
1. Update `PDFSplitter.swift` to read preferences
2. Add PNG rendering capability using PDFKit
3. Update output file naming based on format

### Phase 5: Testing
1. Unit tests for preferences persistence
2. Integration tests for PNG export
3. E2E tests for full workflow

---

## Key Files to Modify

| File | Changes |
|------|---------|
| `SplitPDF/Shared/PDFSplitter.swift` | Add preferences reading, PNG export |
| `SplitPDF/SplitPDF/SplitPDFApp.swift` | Add preferences window |
| `SplitPDF/Shared/Preferences.swift` | NEW - Settings model |
| `SplitPDF/SplitPDF/PreferencesView.swift` | NEW - SwiftUI preferences UI |

---

## Definition of Done

- [ ] Error notifications verified with tests (corrupted, password-protected PDFs)
- [ ] Preferences persist across app restarts
- [ ] Users can select PDF or PNG output format
- [ ] PNG export produces valid image files
- [ ] All tests pass
- [ ] No regressions to existing functionality
