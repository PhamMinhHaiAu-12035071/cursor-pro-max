# USER ACCEPTANCE TESTING (UAT) - DocVault Enterprise Document Management System

**Generated**: 2026-02-10
**Version**: 1.0
**Total Test Cases**: 185
**Priority Distribution**: P0: 62 (33.5%) | P1: 80 (43.2%) | P2: 43 (23.2%)

---

## UAT Summary

| # | Module | Total | P0 | P1 | P2 |
|---|--------|-------|----|----|-----|
| 1 | Authentication & Session | 15 | 7 | 6 | 2 |
| 2 | User Management | 13 | 5 | 5 | 3 |
| 3 | Document Upload | 15 | 7 | 5 | 3 |
| 4 | Document Search | 12 | 3 | 6 | 3 |
| 5 | Version Control | 13 | 4 | 6 | 3 |
| 6 | Permissions & Sharing | 14 | 7 | 5 | 2 |
| 7 | Admin Panel | 12 | 2 | 6 | 4 |
| 8 | Audit Logs | 10 | 3 | 6 | 1 |
| 9 | API Gateway | 14 | 5 | 6 | 3 |
| 10 | Notifications | 10 | 2 | 5 | 3 |
| 11 | Reports & Analytics | 12 | 2 | 6 | 4 |
| 12 | Dashboard | 10 | 2 | 4 | 4 |
| 13 | Integration Hub | 13 | 5 | 5 | 3 |
| 14 | File Conversion | 12 | 4 | 5 | 3 |
| 15 | Archival & Retention | 10 | 4 | 4 | 2 |
| | **Total** | **185** | **62** | **80** | **43** |

---

## MODULE 1: Authentication & Session (15 Test Cases)

### 1.1 LOGIN - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.1.1 | Login with valid email and password | User registered as admin@docvault.com | 1. Navigate to /login<br>2. Enter email: admin@docvault.com<br>3. Enter password: Admin@Secure123<br>4. Click "Sign In" | Redirect to /dashboard<br>Header shows "Welcome, Admin"<br>JWT stored securely<br>Response < 2s | P0 | Not Started | | Email: admin@docvault.com, Password: Admin@Secure123 | Chrome 120+, Desktop |
| UAT-1.1.2 | Login with SSO via Azure AD | Azure AD configured for tenant | 1. Navigate to /login<br>2. Click "Sign in with Microsoft"<br>3. Complete Azure AD authentication<br>4. Consent to permissions if first time | Redirect to /dashboard<br>User profile populated from Azure AD<br>Role mapped from AD groups | P0 | Not Started | | Azure AD test account | Chrome 120+, Desktop |
| UAT-1.1.3 | Login with two-factor authentication | User has 2FA enabled via TOTP app | 1. Enter valid email and password<br>2. Click "Sign In"<br>3. Enter 6-digit TOTP code from authenticator app<br>4. Click "Verify" | 2FA prompt shown after credentials<br>Code accepted, redirect to dashboard<br>Session marked as MFA-verified | P0 | Not Started | | TOTP code from authenticator | Chrome 120+, Desktop |

### 1.2 LOGIN - Error Handling

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.2.1 | Login with incorrect password | User registered | 1. Enter valid email<br>2. Enter wrong password: WrongPass<br>3. Click "Sign In" | Error: "Invalid email or password"<br>No user enumeration<br>Failed attempt logged | P0 | Not Started | | Password: WrongPass | Chrome 120+, Desktop |
| UAT-1.2.2 | Account locked after failed attempts | User with 0 failed attempts | 1. Enter valid email<br>2. Enter wrong password 5 times | Error: "Account locked. Contact administrator."<br>Admin notified via email<br>Lock persists until admin unlocks | P0 | Not Started | | 5 wrong passwords | Chrome 120+, Desktop |
| UAT-1.2.3 | Login with expired password | User password older than 90 days | 1. Enter valid credentials<br>2. Click "Sign In" | Redirect to /change-password<br>Message: "Password expired. Please set a new password."<br>Cannot access other pages until changed | P1 | Not Started | | Account with 90+ day old password | Chrome 120+, Desktop |
| UAT-1.2.4 | Login with disabled account | Admin has disabled the user account | 1. Enter valid credentials for disabled account<br>2. Click "Sign In" | Error: "Your account has been disabled. Contact administrator."<br>No session created | P0 | Not Started | | Disabled account credentials | Chrome 120+, Desktop |

### 1.3 SESSION - Management

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.3.1 | Session timeout after inactivity | User logged in, timeout set to 30 min | 1. Login successfully<br>2. Leave idle for 30+ minutes<br>3. Click any navigation link | Modal: "Session expired. Please sign in again."<br>Redirect to /login after confirming<br>Unsaved work warning if applicable | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-1.3.2 | Force logout from all devices | User logged in on 3 devices | 1. Navigate to /settings/security<br>2. Click "Sign out all devices"<br>3. Confirm action | All other sessions terminated<br>Current session remains active<br>Other devices redirected to /login | P1 | Not Started | | 3 active sessions | Chrome + Safari + Firefox |
| UAT-1.3.3 | Logout clears all sensitive data | User logged in with documents open | 1. Click "Sign Out"<br>2. Confirm logout<br>3. Check browser storage | JWT removed<br>localStorage cleared<br>Cached document data purged<br>Back button shows login page | P0 | Not Started | | N/A | Chrome 120+, Desktop |

### 1.4 SESSION - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.4.1 | Concurrent sessions limit | Max 3 concurrent sessions configured | 1. Login on Device A, B, C<br>2. Attempt login on Device D | Warning: "Maximum sessions reached. Oldest session will be terminated."<br>Device A session ended<br>Device D session created | P1 | Not Started | | 4 devices | Multiple browsers |
| UAT-1.4.2 | Token refresh before expiry | JWT expiry set to 1 hour | 1. Login and wait 55 minutes<br>2. Perform an action | Token silently refreshed<br>No interruption to user<br>New token stored<br>Old token invalidated | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-1.4.3 | Access with tampered JWT | User modifies JWT payload | 1. Login successfully<br>2. Modify JWT in localStorage<br>3. Refresh page | Error: signature verification failed<br>Session terminated<br>Redirect to /login<br>Security event logged | P1 | Not Started | | Modified JWT token | Chrome 120+, Desktop |
| UAT-1.4.4 | Deep link preserves after login | User not logged in | 1. Navigate to /documents/doc-123/version/2<br>2. Redirected to /login<br>3. Login successfully | Redirect to /documents/doc-123/version/2<br>Not to /dashboard<br>Deep link preserved in redirect param | P2 | Not Started | | URL: /documents/doc-123/version/2 | Chrome 120+, Desktop |
| UAT-1.4.5 | Remember device for 2FA | User has 2FA enabled, device not remembered | 1. Login with credentials + 2FA code<br>2. Check "Remember this device for 30 days"<br>3. Logout and login again | 2FA not prompted on remembered device<br>2FA still required on new devices<br>Device trust expires after 30 days | P2 | Not Started | | TOTP code, same browser | Chrome 120+, Desktop |

---

## MODULE 2: User Management (13 Test Cases)

### 2.1 USER CRUD - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-2.1.1 | Create new user with all roles | Admin logged in | 1. Navigate to /admin/users<br>2. Click "Add User"<br>3. Fill: name, email, role (Viewer), department<br>4. Click "Create" | User created<br>Welcome email sent<br>User appears in user list<br>Audit log entry created | P0 | Not Started | | Name: Jane Doe, Email: jane@docvault.com, Role: Viewer | Chrome 120+, Desktop |
| UAT-2.1.2 | Edit user role from Viewer to Editor | Admin logged in, user exists | 1. Navigate to /admin/users<br>2. Click user "Jane Doe"<br>3. Change role to "Editor"<br>4. Click "Save" | Role updated<br>User gains edit permissions immediately<br>Audit log records role change | P0 | Not Started | | User: Jane Doe | Chrome 120+, Desktop |
| UAT-2.1.3 | Deactivate user account | Admin logged in, user is active | 1. Navigate to /admin/users<br>2. Click user row<br>3. Click "Deactivate"<br>4. Confirm action | User status: "Inactive"<br>User cannot login<br>Active sessions terminated<br>Documents remain accessible to other users | P0 | Not Started | | Active user account | Chrome 120+, Desktop |

### 2.2 USER ROLES - Permissions

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-2.2.1 | Viewer cannot upload documents | User logged in with Viewer role | 1. Navigate to /documents<br>2. Look for "Upload" button | Upload button not visible<br>Direct URL to /upload returns 403<br>No file drop zone shown | P0 | Not Started | | User role: Viewer | Chrome 120+, Desktop |
| UAT-2.2.2 | Editor can upload but not delete | User logged in with Editor role | 1. Upload a document successfully<br>2. Navigate to document options<br>3. Check for "Delete" option | Upload succeeds<br>"Delete" option not available<br>Only Admin and Owner can delete | P0 | Not Started | | User role: Editor | Chrome 120+, Desktop |
| UAT-2.2.3 | Admin can perform all operations | User logged in with Admin role | 1. Upload document<br>2. Edit document metadata<br>3. Delete document<br>4. Manage users | All operations succeed<br>No permission errors<br>Full access to admin panel | P1 | Not Started | | User role: Admin | Chrome 120+, Desktop |

### 2.3 USER MANAGEMENT - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-2.3.1 | Bulk import users via CSV | Admin logged in, CSV file with 50 users | 1. Navigate to /admin/users<br>2. Click "Import Users"<br>3. Upload users.csv (50 rows)<br>4. Map columns<br>5. Click "Import" | 50 users created<br>Summary: "48 created, 2 duplicates skipped"<br>Welcome emails sent to new users | P1 | Not Started | | users.csv with 50 rows | Chrome 120+, Desktop |
| UAT-2.3.2 | Create user with duplicate email | Admin logged in, user with same email exists | 1. Navigate to /admin/users<br>2. Click "Add User"<br>3. Enter email of existing user<br>4. Click "Create" | Error: "A user with this email already exists"<br>Form not submitted<br>Link to existing user profile shown | P1 | Not Started | | Duplicate email | Chrome 120+, Desktop |
| UAT-2.3.3 | Search users by name or email | Admin logged in, 100+ users exist | 1. Navigate to /admin/users<br>2. Type "jane" in search bar | Results filter in real-time<br>Matches in name and email shown<br>Result count updates | P1 | Not Started | | Search: "jane", 100+ users | Chrome 120+, Desktop |
| UAT-2.3.4 | User self-service profile update | Regular user logged in | 1. Navigate to /profile<br>2. Update display name and phone<br>3. Click "Save" | Profile updated<br>Cannot change own role or email<br>Role and email fields are read-only | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-2.3.5 | Reactivate previously deactivated user | Admin logged in, user is inactive | 1. Navigate to /admin/users?status=inactive<br>2. Click inactive user<br>3. Click "Reactivate"<br>4. Confirm | User status: "Active"<br>User can login again<br>Previous role and permissions restored | P2 | Not Started | | Inactive user account | Chrome 120+, Desktop |
| UAT-2.3.6 | Delete user permanently | Admin logged in, GDPR deletion request | 1. Navigate to user profile<br>2. Click "Delete Permanently"<br>3. Type user email to confirm<br>4. Click "Delete" | User data purged<br>Documents reassigned to admin<br>Audit log records deletion<br>Cannot be undone | P2 | Not Started | | User with GDPR request | Chrome 120+, Desktop |
| UAT-2.3.7 | User list pagination | Admin logged in, 200+ users | 1. Navigate to /admin/users<br>2. Scroll to bottom<br>3. Click "Next Page" or use infinite scroll | Page 2 loads with next 50 users<br>Total count shown in header<br>Page indicator updates | P2 | Not Started | | 200+ users | Chrome 120+, Desktop |

---

## MODULE 3: Document Upload (15 Test Cases)

### 3.1 UPLOAD - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-3.1.1 | Upload single PDF document | User with Editor role logged in | 1. Navigate to /documents<br>2. Click "Upload"<br>3. Select file: report-2024.pdf (5.2MB)<br>4. Add title: "Annual Report 2024"<br>5. Select category: "Reports"<br>6. Click "Upload" | File uploaded successfully<br>Progress bar 0-100%<br>Document appears in list<br>Thumbnail generated<br>Success toast shown | P0 | Not Started | | File: report-2024.pdf (5.2MB, 24 pages) | Chrome 120+, Desktop |
| UAT-3.1.2 | Upload multiple files at once | User with Editor role | 1. Navigate to /documents<br>2. Click "Upload"<br>3. Select 5 files (mix of PDF, DOCX, XLSX)<br>4. Click "Upload All" | All 5 files uploaded<br>Individual progress bars shown<br>Summary: "5 of 5 uploaded successfully"<br>All appear in document list | P0 | Not Started | | 5 files: 2 PDF, 2 DOCX, 1 XLSX (total 15MB) | Chrome 120+, Desktop |
| UAT-3.1.3 | Drag and drop file upload | User with Editor role, documents page open | 1. Open file explorer<br>2. Drag report.pdf onto the documents page<br>3. Drop on the upload zone | Drop zone highlights on drag-over<br>Upload starts immediately<br>Same behavior as button upload | P1 | Not Started | | File: report.pdf (3MB) | Chrome 120+, Desktop |

### 3.2 UPLOAD - Validation

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-3.2.1 | Upload file exceeding size limit (100MB) | Max file size: 100MB | 1. Click "Upload"<br>2. Select file: huge-archive.zip (150MB) | Error: "File size exceeds 100MB limit"<br>Upload rejected before transfer starts<br>No partial upload | P0 | Not Started | | File: huge-archive.zip (150MB) | Chrome 120+, Desktop |
| UAT-3.2.2 | Upload disallowed file type (.exe) | Allowed types: PDF, DOCX, XLSX, PPTX, PNG, JPG | 1. Click "Upload"<br>2. Select file: malware.exe | Error: "File type .exe is not allowed"<br>Upload rejected<br>List of allowed types shown | P0 | Not Started | | File: malware.exe (1MB) | Chrome 120+, Desktop |
| UAT-3.2.3 | Upload file with duplicate name | Document with same name exists in folder | 1. Upload file "report.pdf"<br>2. Upload another file named "report.pdf" to same folder | Prompt: "A file with this name exists. Rename, replace, or keep both?"<br>Options work correctly for each choice | P1 | Not Started | | Two files named report.pdf | Chrome 120+, Desktop |
| UAT-3.2.4 | Upload with special characters in filename | File with Unicode name | 1. Upload file: "Báo cáo Q4 (final).pdf" | File uploaded successfully<br>Filename preserved<br>No encoding errors<br>Search finds file by name | P1 | Not Started | | File: "Bao cao Q4 (final).pdf" (2MB) | Chrome 120+, Desktop |

### 3.3 UPLOAD - Metadata

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-3.3.1 | Add metadata tags during upload | User uploading a document | 1. Select file for upload<br>2. Add tags: "finance", "Q4", "2024"<br>3. Set category: "Financial Reports"<br>4. Add description: "Quarterly financial review"<br>5. Click "Upload" | Metadata saved with document<br>Tags searchable<br>Category filter works<br>Description shown on detail page | P0 | Not Started | | Tags: finance, Q4, 2024 | Chrome 120+, Desktop |
| UAT-3.3.2 | Edit document metadata after upload | Document already uploaded | 1. Navigate to document detail<br>2. Click "Edit Metadata"<br>3. Change category from "Reports" to "Legal"<br>4. Add tag: "compliance"<br>5. Click "Save" | Metadata updated<br>Document appears under "Legal" category<br>New tag searchable<br>Version unchanged | P1 | Not Started | | Existing document | Chrome 120+, Desktop |

### 3.4 UPLOAD - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-3.4.1 | Upload interrupted by network failure | Upload in progress (50% complete) | 1. Start uploading large file (80MB)<br>2. Disconnect network at 50%<br>3. Reconnect network | Upload pauses with clear status<br>Option to "Resume" or "Cancel"<br>Resume continues from last chunk | P0 | Not Started | | File: large-doc.pdf (80MB) | Chrome 120+, Simulated network |
| UAT-3.4.2 | Upload zero-byte file | User with Editor role | 1. Create empty file: empty.pdf (0 bytes)<br>2. Attempt upload | Error: "Cannot upload empty file"<br>Upload rejected | P1 | Not Started | | File: empty.pdf (0 bytes) | Chrome 120+, Desktop |
| UAT-3.4.3 | Upload password-protected PDF | PDF with password protection | 1. Upload protected.pdf<br>2. System attempts to generate thumbnail | File uploaded successfully<br>Warning: "Password-protected file - preview unavailable"<br>Download still works<br>Metadata extraction skipped | P2 | Not Started | | Password-protected PDF | Chrome 120+, Desktop |
| UAT-3.4.4 | Upload from mobile device | User on mobile browser | 1. Navigate to /documents on mobile<br>2. Tap "Upload"<br>3. Select file from device or camera | Mobile file picker opens<br>Upload works same as desktop<br>Responsive UI during upload | P2 | Not Started | | Any supported file | Safari iOS 17, iPhone |
| UAT-3.4.5 | Concurrent uploads by multiple users | 5 users uploading simultaneously | 1. 5 users start upload at the same time<br>2. Each uploads a different 50MB file | All 5 uploads complete<br>No file corruption<br>No server errors<br>Each user sees own upload progress | P0 | Not Started | | 5 x 50MB files | Multiple browsers |
| UAT-3.4.6 | Upload to nested folder | Folder structure: /Finance/2024/Q4 | 1. Navigate to /Finance/2024/Q4<br>2. Upload document<br>3. Verify breadcrumb shows correct path | Document saved in /Finance/2024/Q4<br>Breadcrumb: Home > Finance > 2024 > Q4<br>Parent folder counts updated | P2 | Not Started | | Any supported file | Chrome 120+, Desktop |

---

## MODULE 4: Document Search (12 Test Cases)

### 4.1 SEARCH - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-4.1.1 | Full-text search across documents | 100+ documents indexed | 1. Click search bar<br>2. Type: "quarterly revenue"<br>3. Press Enter | Results show documents containing "quarterly revenue"<br>Search term highlighted in snippets<br>Results ranked by relevance<br>Response < 3s | P0 | Not Started | | Search: "quarterly revenue" | Chrome 120+, Desktop |
| UAT-4.1.2 | Search by document title | Documents with various titles | 1. Type: "Annual Report" in search<br>2. Press Enter | Documents with "Annual Report" in title appear first<br>Title matches ranked above content matches | P0 | Not Started | | Search: "Annual Report" | Chrome 120+, Desktop |
| UAT-4.1.3 | Search by tag | Documents tagged with "finance" | 1. Click "Tags" filter<br>2. Select tag: "finance"<br>3. View results | Only documents tagged "finance" shown<br>Tag filter badge visible<br>Count matches actual tagged documents | P1 | Not Started | | Tag: "finance" | Chrome 120+, Desktop |

### 4.2 SEARCH - Advanced

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-4.2.1 | Filter by date range | Documents from multiple dates | 1. Search for "report"<br>2. Set date filter: Jan 2024 - Dec 2024<br>3. Apply filter | Only documents from 2024 shown<br>Date range persists in filter bar<br>Result count updates | P1 | Not Started | | Date: 2024-01-01 to 2024-12-31 | Chrome 120+, Desktop |
| UAT-4.2.2 | Filter by file type | Mix of PDF, DOCX, XLSX documents | 1. Search for "budget"<br>2. Filter by type: "XLSX"<br>3. Apply filter | Only XLSX files containing "budget" shown<br>File type icon displayed<br>Combined filters work correctly | P1 | Not Started | | Type filter: XLSX | Chrome 120+, Desktop |
| UAT-4.2.3 | Filter by category | Documents in multiple categories | 1. Open category filter<br>2. Select "Legal"<br>3. View results | Only documents categorized as "Legal" shown<br>Subcategories included<br>Category breadcrumb visible | P1 | Not Started | | Category: Legal | Chrome 120+, Desktop |
| UAT-4.2.4 | Combine multiple search filters | Documents with various attributes | 1. Search: "contract"<br>2. Filter by type: PDF<br>3. Filter by date: 2024<br>4. Filter by category: Legal | Results match ALL criteria<br>Filter badges shown for each active filter<br>"Clear all" removes all filters | P1 | Not Started | | Multiple filters combined | Chrome 120+, Desktop |

### 4.3 SEARCH - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-4.3.1 | Search returns no results | No matching documents | 1. Search for: "zzz_nonexistent_term_xyz" | Empty state: "No documents found"<br>Suggestions: "Try different keywords"<br>Clear search option available | P1 | Not Started | | Search: "zzz_nonexistent_term_xyz" | Chrome 120+, Desktop |
| UAT-4.3.2 | Search with special characters | Documents exist | 1. Search for: "Q4 (final) [draft]" | Search handles special chars gracefully<br>No error or crash<br>Results based on meaningful terms | P2 | Not Started | | Search: "Q4 (final) [draft]" | Chrome 120+, Desktop |
| UAT-4.3.3 | Search respects user permissions | Viewer user, some restricted documents | 1. Login as Viewer<br>2. Search for "confidential"<br>3. View results | Only documents Viewer has access to appear<br>Restricted documents not shown<br>No indication of restricted documents' existence | P0 | Not Started | | User role: Viewer | Chrome 120+, Desktop |
| UAT-4.3.4 | Search pagination for large result sets | 500+ documents match query | 1. Search for common term: "document"<br>2. Scroll through results<br>3. Navigate to page 2 | Results paginated (20 per page)<br>Total count shown: "Showing 1-20 of 523"<br>Page navigation works<br>No performance degradation | P2 | Not Started | | 500+ matching documents | Chrome 120+, Desktop |
| UAT-4.3.5 | Search suggestions and autocomplete | Search history and popular terms exist | 1. Click search bar<br>2. Type "ann"<br>3. Observe suggestions dropdown | Autocomplete shows: "Annual Report", "Announcement"<br>Recent searches shown<br>Click suggestion fills search bar | P2 | Not Started | | N/A | Chrome 120+, Desktop |

---

## MODULE 5: Version Control (13 Test Cases)

### 5.1 VERSIONING - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-5.1.1 | Upload new version of document | Document v1 exists | 1. Navigate to document detail<br>2. Click "Upload New Version"<br>3. Select updated file<br>4. Add version note: "Updated Q4 figures"<br>5. Click "Upload" | Version incremented to v2<br>Previous version preserved<br>Version history shows both<br>Note "Updated Q4 figures" recorded | P0 | Not Started | | Updated file, version note text | Chrome 120+, Desktop |
| UAT-5.1.2 | View version history | Document with 3+ versions | 1. Navigate to document detail<br>2. Click "Version History" tab | All versions listed chronologically<br>Each shows: version number, date, uploader, note<br>Download button for each version | P0 | Not Started | | Document with 3+ versions | Chrome 120+, Desktop |
| UAT-5.1.3 | Download specific version | Document with multiple versions | 1. Open version history<br>2. Click "Download" next to v1<br>3. Open downloaded file | Correct file version downloaded<br>Filename includes version: "report-v1.pdf"<br>File content matches v1 | P0 | Not Started | | Document with 3+ versions | Chrome 120+, Desktop |

### 5.2 VERSIONING - Compare and Restore

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-5.2.1 | Compare two versions side by side | Document with v1 and v2 | 1. Open version history<br>2. Select v1 and v2<br>3. Click "Compare" | Side-by-side comparison shown<br>Differences highlighted<br>Added/removed text marked | P1 | Not Started | | Document v1 and v2 | Chrome 120+, Desktop |
| UAT-5.2.2 | Restore previous version | Document at v3, need to restore v1 | 1. Open version history<br>2. Click "Restore" next to v1<br>3. Confirm restoration | New version v4 created with v1 content<br>v3 preserved in history<br>Note: "Restored from v1" | P0 | Not Started | | Document at v3 | Chrome 120+, Desktop |
| UAT-5.2.3 | Version note is mandatory | Uploading new version | 1. Upload new version<br>2. Leave version note empty<br>3. Click "Upload" | Validation: "Version note is required"<br>Upload blocked until note provided | P1 | Not Started | | Empty version note | Chrome 120+, Desktop |

### 5.3 VERSIONING - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-5.3.1 | Upload version with different file type | Document v1 is PDF, new version is DOCX | 1. Open PDF document<br>2. Upload new version as DOCX | Warning: "File type changed from PDF to DOCX. Continue?"<br>User can confirm or cancel<br>Version history shows type change | P1 | Not Started | | PDF v1, DOCX v2 | Chrome 120+, Desktop |
| UAT-5.3.2 | Concurrent version upload by two users | Two users editing same document | 1. User A starts uploading v2<br>2. User B starts uploading v2 simultaneously | First upload becomes v2<br>Second upload becomes v3 (not overwrite)<br>Both users notified of conflict | P1 | Not Started | | Two users, same document | Two browsers |
| UAT-5.3.3 | Version history with 50+ versions | Document with extensive history | 1. Open version history for document with 50+ versions | History loads with pagination<br>Latest versions shown first<br>Performance acceptable (< 3s load) | P2 | Not Started | | Document with 50+ versions | Chrome 120+, Desktop |
| UAT-5.3.4 | Delete a specific version | Admin wants to remove v2 from history | 1. Open version history as Admin<br>2. Click "Delete" next to v2<br>3. Confirm: "This cannot be undone" | V2 removed from history<br>V1 and v3 still accessible<br>Version numbers not renumbered<br>Audit log records deletion | P1 | Not Started | | Document with 3+ versions | Chrome 120+, Desktop |
| UAT-5.3.5 | Check out document for editing | User wants exclusive edit access | 1. Click "Check Out" on document<br>2. Edit and upload new version<br>3. Click "Check In" | Document locked during checkout<br>Other users see "Checked out by [User]"<br>Only checked-out user can upload<br>Check-in releases lock | P1 | Not Started | | Document available for checkout | Chrome 120+, Desktop |
| UAT-5.3.6 | Auto-checkout timeout | User checked out but inactive for 24h | 1. Check out document<br>2. Wait 24+ hours without uploading | Auto check-in after timeout<br>Notification sent to user<br>Document unlocked for others | P2 | Not Started | | Checked out document, 24h timeout | Chrome 120+, Desktop |
| UAT-5.3.7 | Admin force check-in | Document checked out by inactive user | 1. Admin navigates to document<br>2. Clicks "Force Check In"<br>3. Confirms action | Lock released<br>Original user notified<br>No data loss<br>Audit log records force check-in | P2 | Not Started | | Checked out document | Chrome 120+, Desktop |

---

## MODULE 6: Permissions & Sharing (14 Test Cases)

### 6.1 DOCUMENT PERMISSIONS - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-6.1.1 | Share document with specific user | User owns document | 1. Open document<br>2. Click "Share"<br>3. Enter email: jane@docvault.com<br>4. Set permission: "Can View"<br>5. Click "Share" | User receives access<br>Notification sent to Jane<br>Shared icon appears on document<br>Jane can view but not edit | P0 | Not Started | | Email: jane@docvault.com, Permission: View | Chrome 120+, Desktop |
| UAT-6.1.2 | Share document with edit permission | User owns document | 1. Open document<br>2. Click "Share"<br>3. Enter email: editor@docvault.com<br>4. Set permission: "Can Edit"<br>5. Click "Share" | Editor can view and edit<br>Cannot delete or share further<br>Changes tracked in version history | P0 | Not Started | | Email: editor@docvault.com, Permission: Edit | Chrome 120+, Desktop |
| UAT-6.1.3 | Share folder with team | User owns folder | 1. Right-click folder<br>2. Click "Share Folder"<br>3. Select team: "Finance Team"<br>4. Set permission: "Can View"<br>5. Click "Share" | All team members gain view access<br>Applies to all documents in folder<br>New documents in folder inherit permission | P0 | Not Started | | Team: Finance Team | Chrome 120+, Desktop |

### 6.2 PERMISSION CHANGES

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-6.2.1 | Upgrade permission from View to Edit | User has View access | 1. Open document sharing settings<br>2. Find user with View access<br>3. Change to "Can Edit"<br>4. Click "Save" | Permission updated immediately<br>User can now edit<br>No need to reshare | P1 | Not Started | | User with View permission | Chrome 120+, Desktop |
| UAT-6.2.2 | Revoke document access | User has shared document | 1. Open sharing settings<br>2. Click "Remove" next to user<br>3. Confirm revocation | User loses access immediately<br>Document removed from their view<br>Open sessions for that doc terminated | P0 | Not Started | | Shared document with user | Chrome 120+, Desktop |
| UAT-6.2.3 | Transfer document ownership | Current owner wants to transfer | 1. Open document settings<br>2. Click "Transfer Ownership"<br>3. Select new owner<br>4. Confirm transfer | New owner has full control<br>Previous owner retains Edit access<br>Audit log records transfer | P1 | Not Started | | Document with single owner | Chrome 120+, Desktop |

### 6.3 SHARING - External

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-6.3.1 | Generate shareable link with expiry | Document exists, external sharing enabled | 1. Open document<br>2. Click "Get Link"<br>3. Set expiry: 7 days<br>4. Set permission: "View only"<br>5. Copy link | Link generated<br>Works without login<br>Expires after 7 days<br>View-only (no download option) | P0 | Not Started | | Expiry: 7 days | Chrome 120+, Desktop |
| UAT-6.3.2 | External link with password protection | Document shared via link | 1. Generate shareable link<br>2. Enable "Require Password"<br>3. Set password: Share@123<br>4. Share link with external user | External user must enter password to view<br>Wrong password shows error<br>Correct password grants access | P0 | Not Started | | Password: Share@123 | Chrome 120+, Desktop |
| UAT-6.3.3 | Revoke shareable link | Active shareable link exists | 1. Open sharing settings<br>2. Click "Revoke Link"<br>3. Confirm revocation | Link immediately becomes invalid<br>Visitors see "This link has expired"<br>New link can be generated | P1 | Not Started | | Active shareable link | Chrome 120+, Desktop |

### 6.4 PERMISSIONS - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-6.4.1 | Inherited permissions from parent folder | Folder shared with team, new document added | 1. Share folder "Legal" with Finance Team (View)<br>2. Upload new document to "Legal" folder<br>3. Finance Team member checks access | New document inherits folder permissions<br>Finance Team can view without separate sharing<br>Inheritance shown in permission panel | P0 | Not Started | | Shared folder, new document | Chrome 120+, Desktop |
| UAT-6.4.2 | Override inherited permissions | Document inherits View, need Edit for one user | 1. Open document in shared folder<br>2. Add specific user with "Can Edit"<br>3. Save | User has Edit (overrides folder's View)<br>Other team members still View only<br>Permission source shown: "Direct" vs "Inherited" | P1 | Not Started | | Document in shared folder | Chrome 120+, Desktop |
| UAT-6.4.3 | Share with non-existent email | User enters email not in system | 1. Open document sharing<br>2. Enter email: external@notregistered.com<br>3. Click "Share" | Option: "Send invitation to join DocVault"<br>Pending share created<br>Access granted upon registration | P1 | Not Started | | Email: external@notregistered.com | Chrome 120+, Desktop |
| UAT-6.4.4 | Maximum sharing limit | Document already shared with 100 users | 1. Open sharing settings<br>2. Try to add user 101 | Warning: "Maximum 100 direct shares reached"<br>Suggest using team/group sharing instead | P2 | Not Started | | Document with 100 shares | Chrome 120+, Desktop |
| UAT-6.4.5 | View all documents shared with me | User with multiple shared documents | 1. Navigate to /documents/shared-with-me<br>2. Browse shared documents | All shared documents listed<br>Shows sharer name and permission level<br>Sorted by share date (newest first) | P2 | Not Started | | Multiple shared documents | Chrome 120+, Desktop |

---

## MODULE 7: Admin Panel (12 Test Cases)

### 7.1 SYSTEM CONFIGURATION

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-7.1.1 | Configure max file upload size | Admin logged in | 1. Navigate to /admin/settings<br>2. Set "Max Upload Size" to 200MB<br>3. Click "Save" | Setting saved<br>Upload limit updated system-wide<br>Users see new limit on upload page | P0 | Not Started | | Max size: 200MB | Chrome 120+, Desktop |
| UAT-7.1.2 | Configure allowed file types | Admin logged in | 1. Navigate to /admin/settings<br>2. Add ".ai" to allowed file types<br>3. Remove ".exe" from allowed types<br>4. Click "Save" | File type rules updated<br>Users can upload .ai files<br>.exe uploads blocked | P0 | Not Started | | Add: .ai, Remove: .exe | Chrome 120+, Desktop |
| UAT-7.1.3 | Set session timeout duration | Admin logged in | 1. Navigate to /admin/settings/security<br>2. Set session timeout to 60 minutes<br>3. Click "Save" | New sessions expire after 60 min inactivity<br>Existing sessions use old timeout until renewal | P1 | Not Started | | Timeout: 60 minutes | Chrome 120+, Desktop |
| UAT-7.1.4 | Enable/disable SSO | Admin logged in | 1. Navigate to /admin/settings/authentication<br>2. Toggle "Enable SSO"<br>3. Enter Azure AD config<br>4. Click "Save and Test" | SSO option appears on login page<br>Test connection succeeds<br>Users can login via SSO | P1 | Not Started | | Azure AD credentials | Chrome 120+, Desktop |

### 7.2 STORAGE MANAGEMENT

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-7.2.1 | View storage usage dashboard | Admin logged in | 1. Navigate to /admin/storage | Storage usage displayed<br>Breakdown by: user, department, file type<br>Usage bar shows used/total<br>Warning if > 80% usage | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-7.2.2 | Set storage quota per user | Admin logged in | 1. Navigate to /admin/settings/storage<br>2. Set user quota: 5GB<br>3. Click "Save" | Quota applied to all users<br>Users see remaining quota<br>Upload blocked when quota reached | P1 | Not Started | | Quota: 5GB per user | Chrome 120+, Desktop |

### 7.3 ADMIN - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-7.3.1 | Non-admin accesses admin panel | User with Editor role | 1. Navigate directly to /admin<br>2. Check response | 403 Forbidden<br>Redirect to /dashboard<br>No admin menu visible<br>Attempt logged in audit | P1 | Not Started | | User role: Editor | Chrome 120+, Desktop |
| UAT-7.3.2 | Bulk user role update | Admin logged in, 50+ users selected | 1. Navigate to /admin/users<br>2. Select 50 users via checkbox<br>3. Click "Bulk Actions" > "Change Role"<br>4. Select "Editor"<br>5. Confirm | All 50 users updated to Editor<br>Progress indicator shown<br>Summary: "50 users updated" | P2 | Not Started | | 50 selected users | Chrome 120+, Desktop |
| UAT-7.3.3 | System health monitoring | Admin logged in | 1. Navigate to /admin/health | Server status: OK/Warning/Error<br>Database connection status<br>Storage service status<br>Search index status<br>Last backup timestamp | P2 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-7.3.4 | Export system configuration | Admin logged in | 1. Navigate to /admin/settings<br>2. Click "Export Configuration"<br>3. Download JSON file | Config exported as JSON<br>Contains all settings<br>Sensitive values masked<br>Can be imported on another instance | P2 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-7.3.5 | Admin creates custom role | Admin logged in | 1. Navigate to /admin/roles<br>2. Click "Create Role"<br>3. Name: "Reviewer"<br>4. Set permissions: View + Comment (no Edit)<br>5. Click "Save" | New role "Reviewer" created<br>Can be assigned to users<br>Permissions enforced correctly | P1 | Not Started | | Role name: Reviewer | Chrome 120+, Desktop |
| UAT-7.3.6 | Customize email templates | Admin logged in | 1. Navigate to /admin/settings/email<br>2. Edit "Welcome Email" template<br>3. Change subject and body<br>4. Send test email<br>5. Click "Save" | Template saved<br>Test email received with new format<br>Future invitations use new template | P2 | Not Started | | Custom email template | Chrome 120+, Desktop |

---

## MODULE 8: Audit Logs (10 Test Cases)

### 8.1 AUDIT LOG - Viewing

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-8.1.1 | View audit log entries | Admin logged in, audit events exist | 1. Navigate to /admin/audit-logs<br>2. View recent entries | Entries show: timestamp, user, action, resource, IP address<br>Sorted newest first<br>Pagination for large logs | P0 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-8.1.2 | Filter audit logs by user | Multiple users have performed actions | 1. Navigate to /admin/audit-logs<br>2. Filter by user: "jane@docvault.com"<br>3. Apply filter | Only Jane's actions shown<br>All action types included<br>Filter badge visible | P1 | Not Started | | User: jane@docvault.com | Chrome 120+, Desktop |
| UAT-8.1.3 | Filter audit logs by action type | Various actions logged | 1. Filter by action: "Document Deleted"<br>2. Apply filter | Only deletion events shown<br>Shows who deleted what and when<br>Document name and ID included | P1 | Not Started | | Action: Document Deleted | Chrome 120+, Desktop |
| UAT-8.1.4 | Filter audit logs by date range | Logs span multiple months | 1. Set date range: last 7 days<br>2. Apply filter | Only entries from last 7 days shown<br>Date range selector works correctly<br>Result count updates | P1 | Not Started | | Date: last 7 days | Chrome 120+, Desktop |

### 8.2 AUDIT LOG - Completeness

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-8.2.1 | Login events logged | Users logging in and out | 1. User logs in<br>2. Check audit log | Entry: "User admin@docvault.com logged in from IP 192.168.1.1" | P0 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-8.2.2 | Document operations logged | User uploads, edits, deletes documents | 1. Upload a document<br>2. Edit its metadata<br>3. Delete the document<br>4. Check audit log | Three entries:<br>"Document 'report.pdf' uploaded"<br>"Document 'report.pdf' metadata updated"<br>"Document 'report.pdf' deleted" | P0 | Not Started | | Document: report.pdf | Chrome 120+, Desktop |
| UAT-8.2.3 | Permission changes logged | Admin changes user permissions | 1. Admin changes user role<br>2. Admin shares document<br>3. Check audit log | Entries: "User role changed from Viewer to Editor"<br>"Document shared with jane@docvault.com" | P1 | Not Started | | N/A | Chrome 120+, Desktop |

### 8.3 AUDIT LOG - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-8.3.1 | Export audit logs as CSV | Admin logged in, logs exist | 1. Navigate to audit logs<br>2. Apply date filter<br>3. Click "Export CSV" | CSV downloaded with all visible entries<br>All columns included<br>UTF-8 encoding<br>Filename includes date range | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-8.3.2 | Audit log immutability | Admin logged in | 1. View audit log entries<br>2. Attempt to delete or modify entries | No delete/edit options available<br>Logs are read-only<br>Even super admin cannot modify | P2 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-8.3.3 | Failed access attempts logged | Non-admin attempts admin URL | 1. Editor navigates to /admin<br>2. Check audit log | Entry: "Unauthorized access attempt to /admin by editor@docvault.com"<br>IP address recorded | P1 | Not Started | | User role: Editor | Chrome 120+, Desktop |

---

## MODULE 9: API Gateway (14 Test Cases)

### 9.1 API AUTHENTICATION

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-9.1.1 | Generate API key | User with API access permission | 1. Navigate to /settings/api<br>2. Click "Generate API Key"<br>3. Name key: "Integration-Prod"<br>4. Set scope: "Read Only" | API key generated and displayed once<br>Key name and scope saved<br>Warning: "Copy now, cannot be shown again" | P0 | Not Started | | Key name: Integration-Prod | Chrome 120+, Desktop |
| UAT-9.1.2 | API request with valid key | Valid API key exists | 1. Send GET /api/v1/documents with API key header<br>2. Check response | 200 OK<br>Documents list returned<br>Response matches user's permission scope<br>Response time < 1s | P0 | Not Started | | Valid API key | Postman / curl |
| UAT-9.1.3 | API request with invalid key | No valid key for this value | 1. Send GET /api/v1/documents with invalid key<br>2. Check response | 401 Unauthorized<br>Error: {"error": "Invalid API key"}<br>No data returned<br>Attempt logged in audit | P0 | Not Started | | Invalid API key | Postman / curl |
| UAT-9.1.4 | API request with expired key | API key expired | 1. Use expired API key for request<br>2. Check response | 401 Unauthorized<br>Error: {"error": "API key expired"}<br>Suggestion to regenerate key | P1 | Not Started | | Expired API key | Postman / curl |

### 9.2 API ENDPOINTS

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-9.2.1 | List documents via API | Valid API key with read scope | 1. GET /api/v1/documents<br>2. Check response structure | 200 OK<br>Array of documents with id, title, type, size, dates<br>Pagination headers present<br>Respects user permissions | P0 | Not Started | | Valid API key | Postman / curl |
| UAT-9.2.2 | Upload document via API | Valid API key with write scope | 1. POST /api/v1/documents with multipart file<br>2. Include metadata in body<br>3. Check response | 201 Created<br>Document ID returned<br>File stored and indexed<br>Metadata saved | P0 | Not Started | | File: test.pdf, metadata JSON | Postman / curl |
| UAT-9.2.3 | Download document via API | Document exists, API key has read access | 1. GET /api/v1/documents/{id}/download<br>2. Check response | 200 OK<br>File binary in response body<br>Correct Content-Type header<br>Content-Disposition with filename | P1 | Not Started | | Document ID | Postman / curl |
| UAT-9.2.4 | Search documents via API | Documents exist, API key has read access | 1. GET /api/v1/documents/search?q=report&type=pdf<br>2. Check response | 200 OK<br>Matching documents returned<br>Same results as UI search<br>Pagination supported | P1 | Not Started | | Query: report, type: pdf | Postman / curl |

### 9.3 API - Rate Limiting and Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-9.3.1 | API rate limiting | Rate limit: 100 requests/minute | 1. Send 101 requests in 60 seconds<br>2. Check 101st response | 429 Too Many Requests<br>Header: Retry-After: 45<br>Previous 100 requests succeeded | P1 | Not Started | | 101 rapid requests | Postman / script |
| UAT-9.3.2 | API versioning | v1 and v2 endpoints exist | 1. GET /api/v1/documents<br>2. GET /api/v2/documents<br>3. Compare responses | Both return valid responses<br>V2 includes additional fields<br>V1 not broken by v2 changes | P1 | Not Started | | N/A | Postman / curl |
| UAT-9.3.3 | Revoke API key | Valid API key in use | 1. Navigate to /settings/api<br>2. Click "Revoke" next to key<br>3. Confirm revocation<br>4. Attempt API call with revoked key | Key marked as revoked<br>Subsequent requests return 401<br>Cannot be reactivated | P1 | Not Started | | Active API key | Chrome + Postman |
| UAT-9.3.4 | API response for non-existent resource | Valid API key | 1. GET /api/v1/documents/nonexistent-id<br>2. Check response | 404 Not Found<br>Error: {"error": "Document not found"}<br>No stack trace or internal details leaked | P2 | Not Started | | Non-existent document ID | Postman / curl |
| UAT-9.3.5 | API bulk operations | Valid API key with write scope | 1. POST /api/v1/documents/bulk with 10 document IDs<br>2. Action: "move" to folder "Archive"<br>3. Check response | All 10 documents moved<br>Response: {"success": 10, "failed": 0}<br>Operation atomic or reports partial failures | P2 | Not Started | | 10 document IDs | Postman / curl |
| UAT-9.3.6 | API webhook configuration | Admin with API access | 1. Navigate to /settings/api/webhooks<br>2. Add webhook URL: https://example.com/hook<br>3. Select events: "document.uploaded", "document.deleted"<br>4. Click "Save" | Webhook registered<br>Test ping sent and verified<br>Events trigger webhook calls | P2 | Not Started | | Webhook URL | Chrome 120+, Desktop |

---

## MODULE 10: Notifications (10 Test Cases)

### 10.1 IN-APP NOTIFICATIONS

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-10.1.1 | Notification on document share | Document shared with user | 1. User A shares document with User B<br>2. User B checks notification bell | Bell icon shows unread badge<br>Notification: "User A shared 'report.pdf' with you"<br>Click navigates to document | P0 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-10.1.2 | Notification on comment mention | User @mentioned in comment | 1. User A writes comment: "@UserB please review"<br>2. User B checks notifications | Notification: "User A mentioned you in 'report.pdf'"<br>Click navigates to comment | P0 | Not Started | | Comment with @mention | Chrome 120+, Desktop |
| UAT-10.1.3 | Mark notification as read | Unread notification exists | 1. Click notification bell<br>2. Click a notification | Notification marked as read<br>Unread count decrements<br>Navigation to related resource | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-10.1.4 | Mark all as read | Multiple unread notifications | 1. Click notification bell<br>2. Click "Mark all as read" | All notifications read<br>Badge disappears<br>Notifications remain in list | P1 | Not Started | | 5+ unread notifications | Chrome 120+, Desktop |

### 10.2 EMAIL NOTIFICATIONS

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-10.2.1 | Email for document version update | User following a document | 1. Upload new version of document<br>2. Check follower's email | Email: "New version of 'report.pdf' uploaded by Admin"<br>Sent within 5 minutes<br>Contains link to document | P1 | Not Started | | N/A | Email client |
| UAT-10.2.2 | Disable email notifications | User on notification settings | 1. Navigate to /settings/notifications<br>2. Toggle "Email Notifications" OFF<br>3. Save | No emails sent<br>In-app notifications still work<br>Setting persists | P1 | Not Started | | N/A | Chrome + Email |

### 10.3 NOTIFICATIONS - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-10.3.1 | No self-notification | User edits own document | 1. Upload new version of own document<br>2. Check own notifications | No notification generated for own action<br>Other followers still notified | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-10.3.2 | Notification digest mode | User has digest mode enabled (daily) | 1. Multiple events occur during the day<br>2. Check email at digest time (6 PM) | Single daily email with all events<br>No individual emails during the day<br>Summary format with links | P2 | Not Started | | Multiple events | Email client |
| UAT-10.3.3 | Notification for approaching retention deadline | Document approaching auto-archive date | 1. Document retention: 365 days<br>2. 30 days before deadline | Notification: "report.pdf will be auto-archived in 30 days"<br>Option to extend retention<br>Link to retention settings | P2 | Not Started | | Document near retention date | Chrome 120+, Desktop |
| UAT-10.3.4 | Real-time notification delivery | Two users in same workspace | 1. User A shares document with User B<br>2. User B is online and on the dashboard | Notification appears in real-time (< 5s)<br>No page refresh required<br>Bell icon updates immediately | P2 | Not Started | | Two online users | Two browser tabs |

---

## MODULE 11: Reports & Analytics (12 Test Cases)

### 11.1 REPORTS - Generation

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-11.1.1 | Generate storage usage report | Admin logged in | 1. Navigate to /admin/reports<br>2. Select "Storage Usage"<br>3. Set date range: Last 30 days<br>4. Click "Generate" | Report shows storage trends<br>Breakdown by user, department, file type<br>Chart and table views available | P0 | Not Started | | Date range: last 30 days | Chrome 120+, Desktop |
| UAT-11.1.2 | Generate user activity report | Admin logged in | 1. Navigate to /admin/reports<br>2. Select "User Activity"<br>3. Set date range: Last 7 days<br>4. Click "Generate" | Report shows: logins, uploads, downloads per user<br>Most active users highlighted<br>Inactive users flagged | P0 | Not Started | | Date range: last 7 days | Chrome 120+, Desktop |
| UAT-11.1.3 | Generate document access report | Admin logged in, document selected | 1. Navigate to document detail<br>2. Click "Access Report"<br>3. Set date range | Report shows who accessed, when, what action<br>Download vs view breakdown<br>Unique users count | P1 | Not Started | | Specific document, date range | Chrome 120+, Desktop |

### 11.2 REPORTS - Export

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-11.2.1 | Export report as PDF | Report generated | 1. Generate any report<br>2. Click "Export as PDF"<br>3. Open downloaded file | PDF contains all report data<br>Charts rendered as images<br>Tables formatted correctly<br>Company header included | P1 | Not Started | | Generated report | Chrome 120+, Desktop |
| UAT-11.2.2 | Export report as CSV | Report generated | 1. Generate any report<br>2. Click "Export as CSV"<br>3. Open in Excel | CSV contains tabular data<br>Columns properly separated<br>Special characters handled<br>UTF-8 BOM for Excel compatibility | P1 | Not Started | | Generated report | Chrome + Excel |
| UAT-11.2.3 | Schedule recurring report | Admin logged in | 1. Configure report parameters<br>2. Click "Schedule"<br>3. Set frequency: Weekly on Monday<br>4. Set recipients: admin@docvault.com<br>5. Save | Report generated weekly<br>Emailed to recipients<br>Schedule visible in /admin/reports/scheduled | P1 | Not Started | | Schedule: weekly, Monday | Chrome 120+, Desktop |

### 11.3 REPORTS - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-11.3.1 | Report for date range with no data | No activity in selected period | 1. Select date range with no activity<br>2. Generate report | Empty state: "No data available for selected period"<br>No error or crash<br>Chart shows flat line | P2 | Not Started | | Date range: far future | Chrome 120+, Desktop |
| UAT-11.3.2 | Report with 10,000+ data points | High-activity system | 1. Generate user activity report for full year<br>2. Check performance | Report generates within 30 seconds<br>Pagination on table view<br>Chart aggregates data appropriately | P2 | Not Started | | Full year range, high data | Chrome 120+, Desktop |
| UAT-11.3.3 | Compliance report for GDPR | Admin with compliance access | 1. Navigate to /admin/reports/compliance<br>2. Select "Data Subject Access Report"<br>3. Enter user email<br>4. Generate | Report lists all data stored for that user<br>Documents, metadata, activity, shares<br>Export available for GDPR response | P1 | Not Started | | User email for GDPR request | Chrome 120+, Desktop |
| UAT-11.3.4 | Dashboard widgets show correct data | Admin logged in, activity in last 24h | 1. Navigate to /admin/reports<br>2. Check summary widgets | Widgets show: Total docs, storage used, active users, uploads today<br>Numbers match detailed reports<br>Auto-refresh every 5 minutes | P2 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-11.3.5 | Report access restricted to admins | Editor user attempts report access | 1. Login as Editor<br>2. Navigate to /admin/reports | 403 Forbidden<br>No report menu visible<br>Redirect to documents | P1 | Not Started | | User role: Editor | Chrome 120+, Desktop |
| UAT-11.3.6 | Compare reports between two periods | Two periods with data | 1. Generate storage report for January<br>2. Generate storage report for February<br>3. Click "Compare" | Side-by-side comparison<br>Growth/decline percentages<br>Trend indicators (up/down arrows) | P2 | Not Started | | Two monthly date ranges | Chrome 120+, Desktop |

---

## MODULE 12: Dashboard (10 Test Cases)

### 12.1 DASHBOARD - Display

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-12.1.1 | Dashboard loads with summary widgets | User logged in | 1. Navigate to /dashboard | Widgets: Recent Documents, Quick Upload, Activity Feed, Storage Usage<br>Load time < 3 seconds<br>User name shown in welcome message | P0 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-12.1.2 | Recent documents widget shows latest 10 | User with 20+ documents | 1. Check "Recent Documents" widget on dashboard | Shows 10 most recently accessed documents<br>Each shows: name, type icon, last modified date<br>Click navigates to document | P0 | Not Started | | 20+ documents | Chrome 120+, Desktop |
| UAT-12.1.3 | Activity feed shows team actions | Multiple team members active | 1. Check "Activity Feed" on dashboard | Shows recent actions by team: uploads, edits, shares<br>Real-time updates<br>Scrollable with "Show more" | P1 | Not Started | | Team with recent activity | Chrome 120+, Desktop |

### 12.2 DASHBOARD - Interaction

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-12.2.1 | Quick upload from dashboard | Dashboard loaded | 1. Drag file onto "Quick Upload" widget<br>2. File uploads with default metadata | File uploaded to root folder<br>Success notification<br>Appears in "Recent Documents" immediately | P1 | Not Started | | File: quick-doc.pdf (2MB) | Chrome 120+, Desktop |
| UAT-12.2.2 | Dashboard search bar | Dashboard loaded | 1. Click search bar on dashboard<br>2. Type: "contract"<br>3. Press Enter | Redirects to /search?q=contract<br>Results shown<br>Same as full search functionality | P1 | Not Started | | Search: "contract" | Chrome 120+, Desktop |

### 12.3 DASHBOARD - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-12.3.1 | New user dashboard (empty state) | User just registered, no documents | 1. Login as new user<br>2. View dashboard | Helpful empty states: "Upload your first document"<br>Getting started guide shown<br>No errors or broken widgets | P1 | Not Started | | New user account | Chrome 120+, Desktop |
| UAT-12.3.2 | Dashboard responsive on tablet | User on iPad | 1. Open /dashboard on iPad<br>2. Check layout | Widgets stack vertically<br>All content accessible<br>Touch targets appropriately sized | P2 | Not Started | | N/A | Safari iPad |
| UAT-12.3.3 | Dashboard auto-refresh | Dashboard open for 5+ minutes | 1. Leave dashboard open<br>2. Another user uploads a document<br>3. Wait for refresh cycle | Activity feed updates automatically<br>Recent documents refreshes<br>No full page reload required | P2 | Not Started | | Two users | Chrome 120+, Desktop |
| UAT-12.3.4 | Customize dashboard layout | User on dashboard settings | 1. Click "Customize Dashboard"<br>2. Hide "Storage Usage" widget<br>3. Rearrange "Activity Feed" position<br>4. Save layout | Layout saved for this user<br>Persists across sessions<br>"Reset to Default" option available | P2 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-12.3.5 | Dashboard performance with 10K+ documents | Large document library | 1. Login as user with 10K+ documents<br>2. View dashboard | Dashboard loads within 5 seconds<br>Widgets use aggregated data<br>No timeout or memory issues | P2 | Not Started | | 10K+ documents | Chrome 120+, Desktop |

---

## MODULE 13: Integration Hub (13 Test Cases)

### 13.1 INTEGRATION - Setup

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-13.1.1 | Connect Google Drive integration | Admin logged in, Google Workspace configured | 1. Navigate to /admin/integrations<br>2. Click "Google Drive"<br>3. Click "Connect"<br>4. Authorize via OAuth | Connection established<br>Status: "Connected"<br>Google Drive folders visible for sync | P0 | Not Started | | Google Workspace account | Chrome 120+, Desktop |
| UAT-13.1.2 | Connect SharePoint integration | Admin logged in, SharePoint configured | 1. Navigate to /admin/integrations<br>2. Click "SharePoint"<br>3. Enter SharePoint URL and credentials<br>4. Click "Connect" | Connection established<br>SharePoint libraries visible<br>Sync configuration available | P0 | Not Started | | SharePoint URL and credentials | Chrome 120+, Desktop |
| UAT-13.1.3 | Disconnect integration | Integration currently connected | 1. Navigate to /admin/integrations<br>2. Click connected integration<br>3. Click "Disconnect"<br>4. Confirm | Integration disconnected<br>Synced documents remain<br>No new sync occurs<br>Status: "Disconnected" | P1 | Not Started | | Active integration | Chrome 120+, Desktop |

### 13.2 INTEGRATION - Sync

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-13.2.1 | Sync documents from Google Drive | Google Drive connected with docs | 1. Navigate to /admin/integrations/google-drive<br>2. Select folders to sync<br>3. Click "Start Sync" | Documents imported<br>Progress bar shown<br>Folder structure preserved<br>Metadata mapped correctly | P0 | Not Started | | Google Drive with 50+ docs | Chrome 120+, Desktop |
| UAT-13.2.2 | Two-way sync updates | Google Drive connected, sync active | 1. Upload document in DocVault<br>2. Wait for sync cycle<br>3. Check Google Drive | Document appears in synced Google Drive folder<br>Metadata preserved<br>Sync timestamp updated | P0 | Not Started | | Active two-way sync | Chrome + Google Drive |
| UAT-13.2.3 | Sync conflict resolution | Same document edited in both systems | 1. Edit document in DocVault<br>2. Edit same document in Google Drive<br>3. Wait for sync | Conflict detected<br>Options: "Keep DocVault", "Keep Google", "Keep Both"<br>Selected resolution applied | P1 | Not Started | | Same document, dual edits | Chrome + Google Drive |
| UAT-13.2.4 | Scheduled sync execution | Sync scheduled every 6 hours | 1. Set sync schedule: every 6 hours<br>2. Wait for next sync cycle<br>3. Check sync log | Sync runs on schedule<br>Log shows: start time, docs synced, errors<br>Email notification on failure | P1 | Not Started | | Sync schedule: 6h | Chrome 120+, Desktop |

### 13.3 INTEGRATION - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-13.3.1 | Sync with expired OAuth token | Integration connected, token expired | 1. Wait for token expiry<br>2. Trigger sync | Auto-refresh token if possible<br>If refresh fails: notify admin "Integration requires re-authorization"<br>No data loss | P0 | Not Started | | Expired OAuth token | Chrome 120+, Desktop |
| UAT-13.3.2 | Sync large batch (1000+ documents) | Google Drive with 1000+ documents | 1. Start initial sync with 1000+ docs<br>2. Monitor progress | Sync completes (may take time)<br>Progress indicator with count<br>Batch processing (50 at a time)<br>Resumable on failure | P1 | Not Started | | 1000+ documents | Chrome 120+, Desktop |
| UAT-13.3.3 | Integration permissions respect DocVault roles | Viewer tries to sync own Drive | 1. Login as Viewer<br>2. Navigate to integrations | Integration management not visible<br>Only admins can configure<br>Viewers can access synced docs per DocVault permissions | P1 | Not Started | | User role: Viewer | Chrome 120+, Desktop |
| UAT-13.3.4 | Webhook from external system | External system configured to send webhooks | 1. Configure webhook endpoint<br>2. External system sends document event<br>3. Check DocVault | Document created/updated based on webhook<br>Event logged in audit<br>Retry on failure | P2 | Not Started | | Webhook payload | Postman / external system |
| UAT-13.3.5 | Sync error handling and retry | Network failure during sync | 1. Start sync<br>2. Simulate network failure<br>3. Restore network | Sync pauses on error<br>Retries 3 times<br>After 3 failures: admin notification<br>Partial sync state preserved | P2 | Not Started | | Simulated network failure | Chrome 120+, Desktop |
| UAT-13.3.6 | Delete synced document in source | Document synced from Google Drive, then deleted in Drive | 1. Delete document in Google Drive<br>2. Wait for next sync | Options based on config:<br>A) Auto-delete in DocVault<br>B) Mark as "Source deleted" warning<br>C) Keep in DocVault (archive mode) | P2 | Not Started | | Synced document | Chrome + Google Drive |

---

## MODULE 14: File Conversion (12 Test Cases)

### 14.1 CONVERSION - Supported Formats

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-14.1.1 | Convert DOCX to PDF | DOCX document uploaded | 1. Open document detail<br>2. Click "Convert to PDF"<br>3. Wait for conversion | PDF version created<br>Layout preserved (fonts, images, tables)<br>New version or separate document created<br>Download available | P0 | Not Started | | DOCX with images and tables | Chrome 120+, Desktop |
| UAT-14.1.2 | Convert XLSX to PDF | XLSX spreadsheet uploaded | 1. Open spreadsheet detail<br>2. Click "Convert to PDF"<br>3. Wait for conversion | PDF version created<br>All sheets included or sheet selection offered<br>Column widths fit page<br>Headers/footers preserved | P0 | Not Started | | XLSX with 3 sheets | Chrome 120+, Desktop |
| UAT-14.1.3 | Convert PPTX to PDF | PowerPoint uploaded | 1. Open presentation detail<br>2. Click "Convert to PDF"<br>3. Wait for conversion | PDF version created<br>Slides as individual pages<br>Animations removed, final state rendered<br>Speaker notes option | P1 | Not Started | | PPTX with 20 slides | Chrome 120+, Desktop |

### 14.2 CONVERSION - Preview

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-14.2.1 | Preview PDF in browser | PDF document uploaded | 1. Navigate to document<br>2. Click document title or "Preview" | PDF rendered in browser viewer<br>Zoom, scroll, page navigation work<br>Download button available<br>Load time < 5s for 20-page doc | P0 | Not Started | | PDF: 20 pages, 5MB | Chrome 120+, Desktop |
| UAT-14.2.2 | Preview DOCX in browser | DOCX document uploaded | 1. Click document title | Rendered as HTML preview<br>Basic formatting preserved<br>Images displayed<br>"Download original" option | P1 | Not Started | | DOCX with formatting | Chrome 120+, Desktop |
| UAT-14.2.3 | Preview image files | PNG/JPG image uploaded | 1. Click image document | Image displayed in lightbox/viewer<br>Zoom and pan supported<br>EXIF data shown in metadata | P1 | Not Started | | PNG: 4000x3000, 8MB | Chrome 120+, Desktop |

### 14.3 CONVERSION - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-14.3.1 | Convert corrupted document | Document file is corrupted | 1. Upload corrupted.docx<br>2. Attempt conversion to PDF | Error: "Conversion failed. File may be corrupted."<br>Original file preserved<br>No crash or hang | P0 | Not Started | | Corrupted DOCX file | Chrome 120+, Desktop |
| UAT-14.3.2 | Convert very large document (500 pages) | 500-page DOCX uploaded | 1. Click "Convert to PDF"<br>2. Wait for conversion | Conversion completes (async if long)<br>Progress notification<br>Email notification when done<br>Quality acceptable | P1 | Not Started | | DOCX: 500 pages | Chrome 120+, Desktop |
| UAT-14.3.3 | Convert document with CJK characters | Document with Chinese/Japanese/Korean text | 1. Upload document with CJK text<br>2. Convert to PDF | Characters rendered correctly<br>No missing glyphs or boxes<br>Layout preserved | P2 | Not Started | | DOCX with CJK content | Chrome 120+, Desktop |
| UAT-14.3.4 | Batch convert multiple documents | 5 documents selected | 1. Select 5 documents<br>2. Click "Batch Convert to PDF"<br>3. Wait for completion | All 5 converted<br>Summary: "5 of 5 converted successfully"<br>Individual error reporting if any fail | P2 | Not Started | | 5 mixed format documents | Chrome 120+, Desktop |
| UAT-14.3.5 | Preview unsupported format | .dwg CAD file uploaded | 1. Click .dwg document | Message: "Preview not available for .dwg files"<br>Download button shown<br>File metadata still displayed | P1 | Not Started | | .dwg file | Chrome 120+, Desktop |
| UAT-14.3.6 | Conversion preserves hyperlinks | DOCX with clickable links | 1. Convert DOCX with URLs to PDF<br>2. Open PDF<br>3. Click hyperlinks | Links preserved and clickable in PDF<br>Internal cross-references work<br>External URLs open in browser | P2 | Not Started | | DOCX with hyperlinks | Chrome 120+, Desktop |

---

## MODULE 15: Archival & Retention (10 Test Cases)

### 15.1 RETENTION POLICIES

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-15.1.1 | Configure retention policy | Admin logged in | 1. Navigate to /admin/settings/retention<br>2. Set policy: "Legal documents - 7 years"<br>3. Apply to category: "Legal"<br>4. Click "Save" | Policy created<br>All legal documents tagged with 7-year retention<br>Auto-archive date calculated per document | P0 | Not Started | | Retention: 7 years, Category: Legal | Chrome 120+, Desktop |
| UAT-15.1.2 | Document auto-archived on retention expiry | Document past retention date | 1. Set retention to 1 day for testing<br>2. Wait for retention to expire<br>3. Check document status | Document moved to Archive<br>Access restricted to admin<br>Notification: "Document archived per retention policy"<br>Document recoverable by admin | P0 | Not Started | | Retention: 1 day | Chrome 120+, Desktop |
| UAT-15.1.3 | Manual archive by user | User wants to archive old document | 1. Navigate to document<br>2. Click "..." menu<br>3. Click "Archive"<br>4. Confirm | Document moved to /archive<br>Removed from active views<br>Searchable with archive filter<br>Can be restored | P1 | Not Started | | Active document | Chrome 120+, Desktop |

### 15.2 ARCHIVE MANAGEMENT

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-15.2.1 | Restore archived document | Document in archive | 1. Navigate to /documents/archive<br>2. Find archived document<br>3. Click "Restore"<br>4. Confirm | Document moved back to original folder<br>All metadata preserved<br>Version history intact<br>Permissions restored | P0 | Not Started | | Archived document | Chrome 120+, Desktop |
| UAT-15.2.2 | Permanently delete from archive | Admin, document in archive for 90+ days | 1. Navigate to archive<br>2. Select document<br>3. Click "Permanently Delete"<br>4. Type document name to confirm | Document permanently removed<br>All versions deleted<br>Storage reclaimed<br>Audit log entry created<br>Cannot be recovered | P0 | Not Started | | Archived document, 90+ days | Chrome 120+, Desktop |
| UAT-15.2.3 | Search within archived documents | Multiple archived documents exist | 1. Navigate to /documents/archive<br>2. Search for "contract"<br>3. View results | Only archived documents shown<br>Search works same as active documents<br>Restore option available in results | P1 | Not Started | | Archived documents | Chrome 120+, Desktop |

### 15.3 ARCHIVAL - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-15.3.1 | Legal hold prevents archival | Document under legal hold | 1. Place legal hold on document<br>2. Retention policy expires<br>3. Check document status | Document NOT archived despite expired retention<br>Legal hold takes precedence<br>Admin notification: "Retention blocked by legal hold" | P1 | Not Started | | Document with legal hold | Chrome 120+, Desktop |
| UAT-15.3.2 | Bulk archive old documents | Admin wants to archive all docs older than 2 years | 1. Navigate to /admin/archive<br>2. Set criteria: "Modified before 2024-01-01"<br>3. Preview affected documents<br>4. Click "Archive All" | Preview shows count and list<br>Bulk archive processes<br>Progress indicator<br>Summary report generated | P2 | Not Started | | Documents older than 2 years | Chrome 120+, Desktop |
| UAT-15.3.3 | Archive impact on shared documents | Document shared with 10 users, then archived | 1. Archive shared document<br>2. Shared users attempt access | Shared users notified: "Document has been archived"<br>Previous share links return "Document archived" message<br>Admin contact info provided | P1 | Not Started | | Shared document | Chrome 120+, Desktop |
| UAT-15.3.4 | Retention report | Admin needs compliance overview | 1. Navigate to /admin/reports/retention<br>2. Generate retention report | Shows: documents by retention status<br>Approaching expiry (30 days)<br>Expired but held<br>Archived count<br>Compliance percentage | P2 | Not Started | | Documents with various retention states | Chrome 120+, Desktop |

---

## Coverage Traceability Matrix

| Requirement ID | Requirement Description | Test Case IDs | Coverage Status |
|---------------|------------------------|---------------|-----------------|
| REQ-001 | Users can login with email/password and SSO | UAT-1.1.1, UAT-1.1.2, UAT-1.2.1, UAT-1.2.2, UAT-1.2.4 | Covered |
| REQ-002 | Two-factor authentication | UAT-1.1.3, UAT-1.4.5 | Covered |
| REQ-003 | Account lockout after failed attempts | UAT-1.2.2 | Covered |
| REQ-004 | Password expiry and reset | UAT-1.2.3 | Covered |
| REQ-005 | Session management and timeout | UAT-1.3.1, UAT-1.3.2, UAT-1.3.3, UAT-1.4.1, UAT-1.4.2 | Covered |
| REQ-006 | User CRUD with role management | UAT-2.1.1, UAT-2.1.2, UAT-2.1.3, UAT-2.2.1, UAT-2.2.2, UAT-2.2.3 | Covered |
| REQ-007 | Role-based access control (RBAC) | UAT-2.2.1, UAT-2.2.2, UAT-2.2.3, UAT-6.1.1, UAT-6.1.2 | Covered |
| REQ-008 | Document upload (single, multi, drag-drop) | UAT-3.1.1, UAT-3.1.2, UAT-3.1.3 | Covered |
| REQ-009 | File type and size validation | UAT-3.2.1, UAT-3.2.2 | Covered |
| REQ-010 | Full-text document search | UAT-4.1.1, UAT-4.1.2, UAT-4.1.3, UAT-4.2.1 | Covered |
| REQ-011 | Advanced search filters | UAT-4.2.1, UAT-4.2.2, UAT-4.2.3, UAT-4.2.4 | Covered |
| REQ-012 | Document versioning | UAT-5.1.1, UAT-5.1.2, UAT-5.1.3, UAT-5.2.1, UAT-5.2.2 | Covered |
| REQ-013 | Document check-out/check-in | UAT-5.3.5, UAT-5.3.6, UAT-5.3.7 | Covered |
| REQ-014 | Document sharing (internal and external) | UAT-6.1.1, UAT-6.1.2, UAT-6.3.1, UAT-6.3.2 | Covered |
| REQ-015 | Folder-level permissions with inheritance | UAT-6.1.3, UAT-6.4.1, UAT-6.4.2 | Covered |
| REQ-016 | Admin system configuration | UAT-7.1.1, UAT-7.1.2, UAT-7.1.3, UAT-7.1.4 | Covered |
| REQ-017 | Audit logging (immutable) | UAT-8.1.1, UAT-8.2.1, UAT-8.2.2, UAT-8.2.3, UAT-8.3.2 | Covered |
| REQ-018 | REST API with key authentication | UAT-9.1.1, UAT-9.1.2, UAT-9.1.3, UAT-9.2.1, UAT-9.2.2 | Covered |
| REQ-019 | API rate limiting | UAT-9.3.1 | Covered |
| REQ-020 | In-app and email notifications | UAT-10.1.1, UAT-10.1.2, UAT-10.2.1, UAT-10.2.2 | Covered |
| REQ-021 | Reports and analytics | UAT-11.1.1, UAT-11.1.2, UAT-11.1.3, UAT-11.2.1 | Covered |
| REQ-022 | GDPR compliance reporting | UAT-11.3.3 | Covered |
| REQ-023 | Dashboard with widgets | UAT-12.1.1, UAT-12.1.2, UAT-12.1.3 | Covered |
| REQ-024 | Google Drive / SharePoint integration | UAT-13.1.1, UAT-13.1.2, UAT-13.2.1, UAT-13.2.2 | Covered |
| REQ-025 | Document format conversion | UAT-14.1.1, UAT-14.1.2, UAT-14.2.1 | Covered |
| REQ-026 | Document preview in browser | UAT-14.2.1, UAT-14.2.2, UAT-14.2.3 | Covered |
| REQ-027 | Retention policies and auto-archival | UAT-15.1.1, UAT-15.1.2, UAT-15.1.3 | Covered |
| REQ-028 | Archive management and restoration | UAT-15.2.1, UAT-15.2.2, UAT-15.2.3 | Covered |
| REQ-029 | Legal hold | UAT-15.3.1 | Covered |
| REQ-030 | Mobile responsive access | UAT-3.4.4, UAT-12.3.2 | Covered |
| REQ-031 | Digital signatures and e-signing | | Gap |
| REQ-032 | OCR text extraction from scanned PDFs | | Gap |
| REQ-033 | Custom workflow automation (approval chains) | | Gap |
| REQ-034 | Multi-language UI support (i18n) | | Gap |

---

## Gap Analysis and Recommendations

### Uncovered Areas

| # | Area | Risk Level | Recommendation |
|---|------|-----------|----------------|
| 1 | Digital signatures and e-signing | High | Add 6-8 test cases for document signing workflow, signature verification, multi-party signing, and certificate validation. Critical for legal document management. |
| 2 | OCR text extraction | Medium | Add 4-5 test cases for scanned PDF text extraction, language support, accuracy verification, and searchability of extracted text. |
| 3 | Custom workflow automation | High | Add 8-10 test cases for approval chain creation, routing, escalation, timeout handling, and parallel approvals. Key for enterprise adoption. |
| 4 | Multi-language UI (i18n) | Low | Add 3-4 test cases for language switching, RTL support, and translated content accuracy. Defer to next release if not core. |

### Coverage Summary

- **Total Requirements**: 34
- **Covered**: 30 (88.2%)
- **Gaps**: 4 (11.8%)
- **Risk Assessment**: Medium-High -- Two high-risk gaps (digital signatures, workflow automation) should be addressed before enterprise release. OCR and i18n can be deferred.
