# USER ACCEPTANCE TESTING (UAT) - TaskFlow SaaS Platform

**Generated**: 2026-02-10
**Version**: 1.0
**Total Test Cases**: 50
**Priority Distribution**: P0: 15 (30.0%) | P1: 23 (46.0%) | P2: 12 (24.0%)

---

## UAT Summary

| # | Module | Total | P0 | P1 | P2 |
|---|--------|-------|----|----|-----|
| 1 | Authentication & Session | 12 | 5 | 5 | 2 |
| 2 | Task Management | 12 | 4 | 5 | 3 |
| 3 | Team Collaboration | 10 | 2 | 5 | 3 |
| 4 | Notifications | 8 | 2 | 3 | 3 |
| 5 | User Settings | 8 | 2 | 5 | 1 |
| | **Total** | **50** | **15** | **23** | **12** |

---

## MODULE 1: Authentication & Session (12 Test Cases)

### 1.1 LOGIN - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.1.1 | Login with valid email and password | User registered with email admin@taskflow.com | 1. Navigate to /login<br>2. Enter email: admin@taskflow.com<br>3. Enter password: SecurePass@123<br>4. Click "Sign In" | Redirect to /dashboard<br>Header shows "Welcome, Admin"<br>JWT stored in localStorage<br>Response time < 2s | P0 | Not Started | | Email: admin@taskflow.com, Password: SecurePass@123 | Chrome 120+, Desktop |
| UAT-1.1.2 | Login with "Remember Me" enabled | User registered, "Remember Me" checkbox available | 1. Navigate to /login<br>2. Enter valid credentials<br>3. Check "Remember Me" checkbox<br>4. Click "Sign In"<br>5. Close browser<br>6. Reopen browser and navigate to /dashboard | Session persists after browser restart<br>User is still logged in<br>Token expiry extended to 30 days | P1 | Not Started | | Email: user@taskflow.com, Password: Test@123 | Chrome 120+, Desktop |
| UAT-1.1.3 | Logout successfully | User logged in | 1. Click user avatar in top-right<br>2. Click "Sign Out"<br>3. Confirm logout in modal | Redirect to /login<br>JWT removed from localStorage<br>Back button does not restore session | P0 | Not Started | | N/A | All browsers |

### 1.2 LOGIN - Error Handling

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.2.1 | Login with incorrect password | User registered with known email | 1. Navigate to /login<br>2. Enter email: admin@taskflow.com<br>3. Enter password: WrongPass123<br>4. Click "Sign In" | Error message: "Invalid email or password"<br>Password field cleared<br>No redirect occurs<br>Response time < 2s | P0 | Not Started | | Email: admin@taskflow.com, Password: WrongPass123 | Chrome 120+, Desktop |
| UAT-1.2.2 | Login with unregistered email | No account for this email | 1. Navigate to /login<br>2. Enter email: nobody@taskflow.com<br>3. Enter password: AnyPass123<br>4. Click "Sign In" | Error message: "Invalid email or password"<br>Same error as wrong password (no user enumeration) | P0 | Not Started | | Email: nobody@taskflow.com | Chrome 120+, Desktop |
| UAT-1.2.3 | Account locked after 5 failed attempts | User registered, 0 failed attempts | 1. Navigate to /login<br>2. Enter valid email<br>3. Enter wrong password 5 times<br>4. Attempt 6th login | Error message: "Account locked. Please try again in 30 minutes or reset your password."<br>Lock persists for 30 minutes<br>"Reset Password" link shown | P0 | Not Started | | Email: locktest@taskflow.com | Chrome 120+, Desktop |
| UAT-1.2.4 | Login with empty email field | Login page loaded | 1. Navigate to /login<br>2. Leave email field empty<br>3. Enter password: Test@123<br>4. Click "Sign In" | Inline validation: "Email is required"<br>Form not submitted<br>Email field highlighted in red | P1 | Not Started | | Password: Test@123 | Chrome 120+, Desktop |

### 1.3 PASSWORD RESET - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.3.1 | Request password reset via email | User registered with valid email | 1. Navigate to /login<br>2. Click "Forgot Password?"<br>3. Enter email: admin@taskflow.com<br>4. Click "Send Reset Link" | Success message: "Reset link sent to your email"<br>Email received within 2 minutes<br>Reset link valid for 1 hour | P1 | Not Started | | Email: admin@taskflow.com | Chrome 120+, Desktop |
| UAT-1.3.2 | Complete password reset with valid token | Reset email received with valid token | 1. Click reset link in email<br>2. Enter new password: NewSecure@456<br>3. Confirm password: NewSecure@456<br>4. Click "Reset Password" | Success message: "Password updated successfully"<br>Redirect to /login<br>Old password no longer works<br>New password works | P1 | Not Started | | New password: NewSecure@456 | Chrome 120+, Desktop |

### 1.4 SESSION - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.4.1 | Session expires after 24 hours of inactivity | User logged in, session timeout set to 24h | 1. Login successfully<br>2. Wait 24+ hours without activity<br>3. Click any navigation link | Redirect to /login<br>Message: "Session expired. Please sign in again."<br>Previous page URL preserved for redirect after login | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-1.4.2 | Concurrent sessions on multiple devices | User logged in on Device A | 1. Login on Device A (Chrome Desktop)<br>2. Login on Device B (Safari Mobile)<br>3. Perform actions on both devices | Both sessions active simultaneously<br>Data syncs between devices<br>No forced logout on either device | P2 | Not Started | | N/A | Chrome Desktop + Safari Mobile |
| UAT-1.4.3 | Access protected page while logged out | User not logged in | 1. Clear all cookies and localStorage<br>2. Navigate directly to /dashboard | Redirect to /login<br>After login, redirect back to /dashboard<br>No error page shown | P2 | Not Started | | N/A | All browsers |

---

## MODULE 2: Task Management (12 Test Cases)

### 2.1 CREATE TASK - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-2.1.1 | Create a new task with all fields | User logged in, member of "Project Alpha" | 1. Navigate to /tasks<br>2. Click "+ New Task"<br>3. Enter title: "Design login page"<br>4. Set due date: 2026-03-01<br>5. Set priority: High<br>6. Assign to: John Doe<br>7. Add description: "Create responsive login page"<br>8. Click "Create Task" | Task appears in task list<br>Success toast: "Task created"<br>All fields saved correctly<br>Task ID generated (e.g., TASK-001) | P0 | Not Started | | Title: "Design login page", Due: 2026-03-01 | Chrome 120+, Desktop |
| UAT-2.1.2 | Create task with only required fields | User logged in | 1. Navigate to /tasks<br>2. Click "+ New Task"<br>3. Enter title: "Quick fix"<br>4. Leave all optional fields empty<br>5. Click "Create Task" | Task created with title only<br>Optional fields show defaults (no assignee, no due date, priority: Medium) | P1 | Not Started | | Title: "Quick fix" | Chrome 120+, Desktop |

### 2.2 UPDATE TASK - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-2.2.1 | Update task status from To Do to In Progress | Task "TASK-001" exists with status "To Do" | 1. Navigate to /tasks/TASK-001<br>2. Click status dropdown<br>3. Select "In Progress"<br>4. Click "Save" | Status updated to "In Progress"<br>Activity log shows "Status changed from To Do to In Progress"<br>Updated timestamp refreshed | P0 | Not Started | | Task ID: TASK-001 | Chrome 120+, Desktop |
| UAT-2.2.2 | Mark task as complete | Task "TASK-001" exists with status "In Progress" | 1. Navigate to /tasks/TASK-001<br>2. Click status dropdown<br>3. Select "Done"<br>4. Click "Save" | Status updated to "Done"<br>Task moves to "Completed" section<br>Completion date recorded<br>Assigned user notified | P0 | Not Started | | Task ID: TASK-001 | Chrome 120+, Desktop |
| UAT-2.2.3 | Edit task description | Task exists with existing description | 1. Navigate to task detail<br>2. Click description area<br>3. Modify text to "Updated description with details"<br>4. Click outside or press Ctrl+S | Description saved<br>Activity log shows "Description updated"<br>Previous version preserved in history | P1 | Not Started | | N/A | Chrome 120+, Desktop |

### 2.3 DELETE TASK - Happy Path and Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-2.3.1 | Delete a task with confirmation | Task "TASK-002" exists, user has delete permission | 1. Navigate to /tasks/TASK-002<br>2. Click "..." menu<br>3. Click "Delete Task"<br>4. Confirm in modal: "Are you sure? This cannot be undone."<br>5. Click "Delete" | Task removed from list<br>Success toast: "Task deleted"<br>Task no longer accessible via URL<br>Related comments also deleted | P0 | Not Started | | Task ID: TASK-002 | Chrome 120+, Desktop |
| UAT-2.3.2 | Cancel task deletion | Task exists | 1. Navigate to task detail<br>2. Click "..." menu<br>3. Click "Delete Task"<br>4. Click "Cancel" in confirmation modal | Modal closes<br>Task is unchanged<br>No deletion occurs | P2 | Not Started | | N/A | Chrome 120+, Desktop |

### 2.4 TASK FILTERING AND SEARCH

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-2.4.1 | Filter tasks by status | At least 10 tasks exist with mixed statuses | 1. Navigate to /tasks<br>2. Click "Filter" dropdown<br>3. Select status: "In Progress"<br>4. Click "Apply" | Only "In Progress" tasks shown<br>Count updates in header<br>Other tasks hidden but not deleted | P1 | Not Started | | 10+ tasks with various statuses | Chrome 120+, Desktop |
| UAT-2.4.2 | Search tasks by keyword | Tasks with various titles exist | 1. Navigate to /tasks<br>2. Click search bar<br>3. Type: "login"<br>4. Press Enter or wait for auto-search | Tasks containing "login" in title or description shown<br>Search term highlighted<br>Results update within 500ms | P1 | Not Started | | Search term: "login" | Chrome 120+, Desktop |
| UAT-2.4.3 | Sort tasks by due date | Tasks with various due dates exist | 1. Navigate to /tasks<br>2. Click "Due Date" column header<br>3. Click again to reverse sort | Tasks sorted by due date ascending then descending<br>Tasks without due date appear at end<br>Sort indicator arrow shown | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-2.4.4 | Search returns empty state | No tasks match the search term | 1. Navigate to /tasks<br>2. Search for: "zzz_nonexistent_task"<br>3. Observe results | Empty state shown: "No tasks found matching your search"<br>Clear search button available<br>Suggestion: "Try different keywords" | P2 | Not Started | | Search term: "zzz_nonexistent_task" | Chrome 120+, Desktop |
| UAT-2.4.5 | Filter tasks by assignee and priority combined | Multiple tasks with different assignees and priorities | 1. Navigate to /tasks<br>2. Filter by assignee: "John Doe"<br>3. Add filter by priority: "High"<br>4. Click "Apply" | Only tasks assigned to John with High priority shown<br>Filter badges show active filters<br>"Clear all filters" button available | P2 | Not Started | | N/A | Chrome 120+, Desktop |

---

## MODULE 3: Team Collaboration (10 Test Cases)

### 3.1 TASK COMMENTS - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-3.1.1 | Add a comment to a task | User logged in, task "TASK-001" exists | 1. Navigate to /tasks/TASK-001<br>2. Scroll to comments section<br>3. Type: "Looks good, proceeding with implementation"<br>4. Click "Post Comment" | Comment appears below previous comments<br>Shows username, avatar, timestamp<br>Comment count increments | P0 | Not Started | | Comment text: "Looks good, proceeding with implementation" | Chrome 120+, Desktop |
| UAT-3.1.2 | Edit own comment | User has posted a comment on a task | 1. Navigate to task with own comment<br>2. Click "..." on own comment<br>3. Click "Edit"<br>4. Modify text to "Updated: implementation complete"<br>5. Click "Save" | Comment updated with new text<br>"(edited)" label shown<br>Edit timestamp recorded | P1 | Not Started | | Updated text: "Updated: implementation complete" | Chrome 120+, Desktop |
| UAT-3.1.3 | Delete own comment | User has posted a comment | 1. Click "..." on own comment<br>2. Click "Delete"<br>3. Confirm deletion | Comment removed<br>Comment count decrements<br>Other comments unaffected | P1 | Not Started | | N/A | Chrome 120+, Desktop |

### 3.2 TEAM MEMBERS - Management

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-3.2.1 | Invite team member via email | User is project admin | 1. Navigate to /settings/team<br>2. Click "Invite Member"<br>3. Enter email: newuser@company.com<br>4. Select role: "Member"<br>5. Click "Send Invitation" | Invitation email sent<br>Pending invite shown in team list<br>Success toast: "Invitation sent" | P0 | Not Started | | Email: newuser@company.com, Role: Member | Chrome 120+, Desktop |
| UAT-3.2.2 | Change team member role | User is project admin, member exists | 1. Navigate to /settings/team<br>2. Click member's role dropdown<br>3. Change from "Member" to "Admin"<br>4. Confirm role change | Role updated immediately<br>Member gains admin permissions<br>Activity log records the change | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-3.2.3 | Remove team member from project | User is project admin | 1. Navigate to /settings/team<br>2. Click "..." next to member name<br>3. Click "Remove from project"<br>4. Confirm removal | Member removed from team list<br>Member loses access to project<br>Member's assigned tasks become unassigned | P1 | Not Started | | N/A | Chrome 120+, Desktop |

### 3.3 COLLABORATION - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-3.3.1 | Non-admin attempts to invite member | User logged in with "Member" role | 1. Navigate to /settings/team<br>2. Look for "Invite Member" button | "Invite Member" button not visible or disabled<br>No unauthorized access to invite functionality | P1 | Not Started | | User role: Member | Chrome 120+, Desktop |
| UAT-3.3.2 | Invite already registered user | Target email belongs to existing platform user | 1. Navigate to /settings/team<br>2. Click "Invite Member"<br>3. Enter email of existing user<br>4. Click "Send Invitation" | User added to project directly (no email needed)<br>Or: message "User already on platform, invitation sent" | P2 | Not Started | | Email of existing user | Chrome 120+, Desktop |
| UAT-3.3.3 | View task activity across team | Multiple team members have edited a task | 1. Navigate to task with multiple edits<br>2. Click "Activity" tab | Activity log shows all changes with author, timestamp, and action<br>Sorted newest first<br>Shows: status changes, comments, assignee changes | P2 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-3.3.4 | @mention team member in comment | Multiple team members in project | 1. Navigate to task comments<br>2. Type "@" in comment box<br>3. Select team member from dropdown<br>4. Post comment | Mentioned user appears as link<br>Mentioned user receives notification<br>Autocomplete shows matching members | P2 | Not Started | | N/A | Chrome 120+, Desktop |

---

## MODULE 4: Notifications (8 Test Cases)

### 4.1 IN-APP NOTIFICATIONS - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-4.1.1 | Receive notification when assigned to task | User logged in, another user assigns a task | 1. User B assigns task "TASK-005" to User A<br>2. User A checks notification bell icon | Bell icon shows unread count (red badge)<br>Notification: "User B assigned you to 'TASK-005'"<br>Click notification navigates to task | P0 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-4.1.2 | Mark notification as read | User has unread notifications | 1. Click notification bell<br>2. Click on a notification<br>3. Observe notification state | Notification marked as read (no longer bold)<br>Unread count decrements<br>Click navigates to related item | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-4.1.3 | Mark all notifications as read | User has 5+ unread notifications | 1. Click notification bell<br>2. Click "Mark all as read" | All notifications marked as read<br>Unread count resets to 0<br>Badge disappears | P1 | Not Started | | N/A | Chrome 120+, Desktop |

### 4.2 EMAIL NOTIFICATIONS

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-4.2.1 | Email sent for task assignment | User has email notifications enabled | 1. Assign a task to user with email notifications on<br>2. Check user's email inbox | Email received within 5 minutes<br>Subject: "You've been assigned to 'Task Name'"<br>Email contains task link and details | P0 | Not Started | | N/A | Email client |
| UAT-4.2.2 | No email when notifications disabled | User has email notifications turned off | 1. Navigate to /settings/notifications<br>2. Disable email notifications<br>3. Another user assigns a task<br>4. Check email | No email received<br>In-app notification still received | P1 | Not Started | | N/A | Chrome + Email client |

### 4.3 NOTIFICATIONS - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-4.3.1 | Notification for due date approaching | Task assigned to user with due date tomorrow | 1. Create task with due date = tomorrow<br>2. Wait for scheduled notification check<br>3. Check notifications | Notification: "Task 'Task Name' is due tomorrow"<br>Sent 24 hours before due date | P2 | Not Started | | Task with due date = tomorrow | Chrome 120+, Desktop |
| UAT-4.3.2 | Notification pagination for 50+ items | User has 50+ notifications | 1. Click notification bell<br>2. Scroll to bottom of notification list<br>3. Look for "Load more" or infinite scroll | Additional notifications load<br>Older notifications accessible<br>No performance degradation | P2 | Not Started | | 50+ notifications in system | Chrome 120+, Desktop |
| UAT-4.3.3 | Self-action does not trigger notification | User modifies own task | 1. User A updates status of own task<br>2. Check User A's notifications | No notification generated for own action<br>Other watchers still notified | P2 | Not Started | | N/A | Chrome 120+, Desktop |

---

## MODULE 5: User Settings (8 Test Cases)

### 5.1 PROFILE SETTINGS - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-5.1.1 | Update display name | User logged in | 1. Navigate to /settings/profile<br>2. Clear "Display Name" field<br>3. Enter: "John Updated"<br>4. Click "Save Changes" | Success toast: "Profile updated"<br>Header shows "John Updated"<br>Profile page reflects new name | P0 | Not Started | | Display Name: "John Updated" | Chrome 120+, Desktop |
| UAT-5.1.2 | Upload profile avatar | User logged in, no avatar set | 1. Navigate to /settings/profile<br>2. Click "Upload Avatar"<br>3. Select file: avatar.png (200x200, 45KB)<br>4. Crop and confirm<br>5. Click "Save" | Avatar displayed in header and profile<br>Image resized to standard dimensions<br>Success toast shown | P1 | Not Started | | File: avatar.png (200x200, 45KB, PNG) | Chrome 120+, Desktop |
| UAT-5.1.3 | Change password | User logged in, knows current password | 1. Navigate to /settings/security<br>2. Enter current password<br>3. Enter new password: NewSecure@789<br>4. Confirm new password: NewSecure@789<br>5. Click "Update Password" | Success toast: "Password updated"<br>Old password no longer works<br>All other sessions invalidated | P0 | Not Started | | Current: SecurePass@123, New: NewSecure@789 | Chrome 120+, Desktop |

### 5.2 NOTIFICATION PREFERENCES

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-5.2.1 | Toggle email notifications off | Email notifications currently enabled | 1. Navigate to /settings/notifications<br>2. Toggle "Email Notifications" to OFF<br>3. Click "Save Preferences" | Toggle shows OFF state<br>Success toast: "Preferences saved"<br>No email notifications sent after change | P1 | Not Started | | N/A | Chrome 120+, Desktop |
| UAT-5.2.2 | Customize notification types | User on settings page | 1. Navigate to /settings/notifications<br>2. Disable "Task Comments" notifications<br>3. Keep "Task Assignments" enabled<br>4. Click "Save Preferences" | Only task assignment notifications received<br>Task comment notifications suppressed<br>Preferences persist across sessions | P1 | Not Started | | N/A | Chrome 120+, Desktop |

### 5.3 SETTINGS - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-5.3.1 | Upload oversized avatar | User logged in | 1. Navigate to /settings/profile<br>2. Click "Upload Avatar"<br>3. Select file: large-image.png (15MB) | Error message: "File size must be under 5MB"<br>Upload rejected<br>Current avatar unchanged | P1 | Not Started | | File: large-image.png (15MB) | Chrome 120+, Desktop |
| UAT-5.3.2 | Change password with weak password | User logged in | 1. Navigate to /settings/security<br>2. Enter current password<br>3. Enter new password: "123"<br>4. Click "Update Password" | Error: "Password must be at least 8 characters with uppercase, lowercase, number, and special character"<br>Password not changed | P1 | Not Started | | Weak password: "123" | Chrome 120+, Desktop |
| UAT-5.3.3 | Profile displays with very long display name | User logged in | 1. Navigate to /settings/profile<br>2. Enter display name: "Abcdefghijklmnopqrstuvwxyz Abcdefghijklmnopqrstuvwxyz" (52 chars)<br>3. Click "Save Changes" | Name truncated or wrapped gracefully in header<br>Full name shown on profile page<br>No UI overflow or layout break | P2 | Not Started | | Name: 52-character string | Chrome 120+, Desktop |

---

## Coverage Traceability Matrix

| Requirement ID | Requirement Description | Test Case IDs | Coverage Status |
|---------------|------------------------|---------------|-----------------|
| REQ-001 | Users can register and login with email/password | UAT-1.1.1, UAT-1.2.1, UAT-1.2.2 | Covered |
| REQ-002 | Users can reset their password via email | UAT-1.3.1, UAT-1.3.2 | Covered |
| REQ-003 | Account locks after 5 failed login attempts | UAT-1.2.3 | Covered |
| REQ-004 | Users can create, edit, and delete tasks | UAT-2.1.1, UAT-2.1.2, UAT-2.2.1, UAT-2.2.2, UAT-2.2.3, UAT-2.3.1 | Covered |
| REQ-005 | Tasks can be filtered by status, assignee, and priority | UAT-2.4.1, UAT-2.4.2, UAT-2.4.3, UAT-2.4.5 | Covered |
| REQ-006 | Users can search tasks by keyword | UAT-2.4.2, UAT-2.4.4 | Covered |
| REQ-007 | Team members can comment on tasks | UAT-3.1.1, UAT-3.1.2, UAT-3.1.3 | Covered |
| REQ-008 | Project admins can invite and manage team members | UAT-3.2.1, UAT-3.2.2, UAT-3.2.3, UAT-3.3.1 | Covered |
| REQ-009 | Users receive in-app notifications for assignments | UAT-4.1.1, UAT-4.1.2, UAT-4.1.3 | Covered |
| REQ-010 | Users receive email notifications (configurable) | UAT-4.2.1, UAT-4.2.2, UAT-5.2.1, UAT-5.2.2 | Covered |
| REQ-011 | Users can update their profile and avatar | UAT-5.1.1, UAT-5.1.2 | Covered |
| REQ-012 | Users can change their password | UAT-5.1.3, UAT-5.3.2 | Covered |
| REQ-013 | Tasks display activity history | UAT-3.3.3 | Covered |
| REQ-014 | @mention team members in comments | UAT-3.3.4 | Covered |
| REQ-015 | Due date reminders sent 24h before deadline | UAT-4.3.1 | Covered |
| REQ-016 | User sessions expire after inactivity | UAT-1.4.1 | Covered |
| REQ-017 | OAuth/SSO login support | | Gap |
| REQ-018 | Task file attachments | | Gap |
| REQ-019 | Task subtasks and checklists | | Gap |

---

## Gap Analysis and Recommendations

### Uncovered Areas

| # | Area | Risk Level | Recommendation |
|---|------|-----------|----------------|
| 1 | OAuth/SSO login (Google, GitHub) | Medium | Add 3-4 test cases for OAuth flow, token exchange, and account linking in Module 1 |
| 2 | Task file attachments | High | Add a new scenario in Module 2 for file upload, download, preview, and deletion (5-6 test cases) |
| 3 | Task subtasks and checklists | Medium | Add a new scenario in Module 2 for creating subtasks, marking complete, and progress tracking (4-5 test cases) |

### Coverage Summary

- **Total Requirements**: 19
- **Covered**: 16 (84.2%)
- **Gaps**: 3 (15.8%)
- **Risk Assessment**: Medium -- Gaps are in secondary features. Core business flows are fully covered. Address file attachments gap before release (High risk).
