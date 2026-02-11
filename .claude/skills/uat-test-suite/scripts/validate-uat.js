#!/usr/bin/env node
// File: .claude/skills/uat-test-suite/scripts/validate-uat.js
//
// Validate UAT markdown file structure, test case consistency, and quality gates.
// Zero dependencies -- uses only Node.js built-in modules.
//
// Usage: node validate-uat.js <UAT-file.md>
//
// Exit codes:
//   0 = All checks passed (Level 1 + Level 2)
//   1 = Level 1 failure (structural integrity broken)
//   2 = Level 1 passed but Level 2 warnings exist (quality gates)

"use strict";

const fs = require("fs");
const path = require("path");

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const ID_PATTERN = /UAT-\d+\.\d+\.\d+/g;
const ID_STRICT = /^UAT-(\d+)\.(\d+)\.(\d+)$/;
const VALID_PRIORITIES = new Set(["P0", "P1", "P2"]);
const VALID_STATUSES = new Set([
  "Not Started",
  "Pass",
  "Fail",
  "Blocked",
  "Skipped",
  "",
]);
const REQUIRED_COLUMNS = ["ID", "Test Case", "Steps", "Expected Result", "Priority"];

// Quality gate thresholds
const PRIORITY_RANGES = {
  P0: { min: 0.20, max: 0.45, label: "20-45%" },
  P1: { min: 0.35, max: 0.55, label: "35-55%" },
  P2: { min: 0.15, max: 0.35, label: "15-35%" },
};
const MIN_TESTS_PER_MODULE = 8;
const CRITICAL_MODULE_MIN_P0_RATIO = 0.35;
const CRITICAL_MODULE_KEYWORDS = [
  "auth", "login", "security", "payment", "checkout", "transaction",
  "billing", "session", "permission", "access control",
];

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

function readFile(filePath) {
  if (!fs.existsSync(filePath)) {
    console.error(`Error: File not found -- ${filePath}`);
    process.exit(1);
  }
  return fs.readFileSync(filePath, "utf-8");
}

function extractAllTestIds(content) {
  const ids = [];
  const lines = content.split("\n");
  let inExcludedSection = false;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    // Stop counting test IDs when we reach non-test-case sections
    if (/^#+\s*(Coverage Traceability|Gap Analysis|Column Reference|Priority Reference|Status Reference)/i.test(line)) {
      inExcludedSection = true;
      continue;
    }

    // Resume if we hit a MODULE section again (unlikely but safe)
    if (/^#+\s*MODULE\s+\d+/i.test(line)) {
      inExcludedSection = false;
    }

    if (inExcludedSection) continue;

    const matches = lines[i].match(ID_PATTERN);
    if (matches) {
      for (const id of matches) {
        // Only count IDs that appear at the start of a table cell (| UAT-...)
        if (lines[i].includes(`| ${id}`)) {
          ids.push({ id, line: i + 1 });
        }
      }
    }
  }
  return ids;
}

function extractSummaryTable(content) {
  const lines = content.split("\n");
  const modules = [];
  let totals = null;
  let inSummary = false;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    // Detect summary section
    if (/^#+\s*UAT\s+Summary/i.test(line)) {
      inSummary = true;
      continue;
    }

    // Stop at the next heading that isn't summary-related
    if (inSummary && /^#+\s/.test(line) && !/summary/i.test(line)) {
      break;
    }

    if (!inSummary) continue;

    // Parse table rows (skip header and separator)
    if (line.startsWith("|") && !line.includes("---") && !line.includes("Module")) {
      const cells = line
        .split("|")
        .map((c) => c.trim())
        .filter(Boolean);

      if (cells.length < 4) continue;

      // Check if this is the totals row
      if (/total/i.test(cells[0]) || /total/i.test(cells[1])) {
        const nums = cells.map((c) => parseInt(c.replace(/\*|\#/g, "").trim(), 10));
        const validNums = nums.filter((n) => !isNaN(n));
        if (validNums.length >= 4) {
          totals = {
            total: validNums[validNums.length - 4],
            p0: validNums[validNums.length - 3],
            p1: validNums[validNums.length - 2],
            p2: validNums[validNums.length - 1],
          };
        }
      } else {
        // Module row
        const nums = cells.map((c) => parseInt(c.replace(/\*|\#/g, "").trim(), 10));
        const validNums = nums.filter((n) => !isNaN(n));
        if (validNums.length >= 4) {
          const nameCell = cells.find((c) => isNaN(parseInt(c.replace(/\*|\#/g, "").trim(), 10)) && c.length > 2);
          modules.push({
            name: nameCell || cells[1] || "Unknown",
            total: validNums[validNums.length - 4],
            p0: validNums[validNums.length - 3],
            p1: validNums[validNums.length - 2],
            p2: validNums[validNums.length - 1],
          });
        }
      }
    }
  }

  return { modules, totals };
}

function extractModuleTestCases(content) {
  const lines = content.split("\n");
  const modules = new Map(); // moduleNum -> { name, p0, p1, p2, total, ids }
  let currentModule = null;
  let currentModuleName = "";

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    // Stop counting when we reach non-module sections
    if (/^#+\s*(Coverage Traceability|Gap Analysis|Column Reference|Priority Reference|Status Reference)/i.test(line)) {
      currentModule = null;
      continue;
    }

    // Detect module header: ## MODULE N: Name (X Test Cases)
    const moduleMatch = line.match(/^#+\s*MODULE\s+(\d+)[\s:]+(.+?)(?:\s*\(\d+\s*Test\s*Cases?\))?\s*$/i);
    if (moduleMatch) {
      currentModule = parseInt(moduleMatch[1], 10);
      currentModuleName = moduleMatch[2].trim();
      if (!modules.has(currentModule)) {
        modules.set(currentModule, { name: currentModuleName, p0: 0, p1: 0, p2: 0, total: 0, ids: [] });
      }
      continue;
    }

    // Parse test case rows
    if (currentModule !== null && line.startsWith("|")) {
      const idMatch = line.match(/UAT-(\d+)\.\d+\.\d+/);
      if (idMatch) {
        const mod = modules.get(currentModule);
        mod.total++;
        mod.ids.push(idMatch[0]);

        // Extract priority
        if (/\|\s*P0\s*\|/.test(line)) mod.p0++;
        else if (/\|\s*P1\s*\|/.test(line)) mod.p1++;
        else if (/\|\s*P2\s*\|/.test(line)) mod.p2++;
      }
    }

    // Reset module if we hit a new top-level section that isn't a module or scenario
    if (/^#+\s/.test(line) && !/MODULE/i.test(line) && !/^\d+\.\d+/.test(line.replace(/^#+\s*/, ""))) {
      if (!/Happy|Edge|Error|Security|Alternative|Scenario|Permission|Filter|Matrix|Boundary|State/i.test(line)) {
        // Only reset if it's a major section, not a sub-scenario
        if (/^##\s/.test(line) && !/^\d/.test(line.replace(/^##\s*/, ""))) {
          currentModule = null;
        }
      }
    }
  }

  return modules;
}

function extractTraceabilityIds(content) {
  const lines = content.split("\n");
  let inTraceability = false;
  const referencedIds = new Set();
  const requirements = [];

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    if (/^#+\s*Coverage Traceability/i.test(line)) {
      inTraceability = true;
      continue;
    }

    if (inTraceability && /^#+\s/.test(line) && !/Coverage Traceability/i.test(line)) {
      break;
    }

    if (!inTraceability) continue;

    // Parse table rows
    if (line.startsWith("|") && !line.includes("---") && !line.includes("Requirement ID")) {
      const cells = line.split("|").map((c) => c.trim()).filter(Boolean);
      if (cells.length >= 4) {
        const reqId = cells[0];
        const reqDesc = cells[1];
        const testIdCell = cells[2];
        const status = cells[3];

        const ids = testIdCell.match(ID_PATTERN) || [];
        ids.forEach((id) => referencedIds.add(id));

        requirements.push({
          reqId,
          description: reqDesc,
          testIds: ids,
          status,
          line: i + 1,
        });
      }
    }
  }

  return { referencedIds, requirements };
}

function checkTableCells(content) {
  const issues = [];
  const lines = content.split("\n");
  let inTestTable = false;
  let headerColumns = [];

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    // Detect test case table header
    if (line.startsWith("|") && /\bID\b/.test(line) && /\bTest Case\b/.test(line)) {
      inTestTable = true;
      headerColumns = line
        .split("|")
        .map((c) => c.trim())
        .filter(Boolean);
      continue;
    }

    // Skip separator rows
    if (line.startsWith("|") && line.includes("---")) {
      continue;
    }

    // Check test case rows
    if (inTestTable && line.startsWith("|") && /UAT-\d+/.test(line)) {
      const cells = line
        .split("|")
        .map((c) => c.trim())
        .filter(Boolean);

      // Check required columns for empty values
      for (const reqCol of REQUIRED_COLUMNS) {
        const colIndex = headerColumns.findIndex(
          (h) => h.toLowerCase() === reqCol.toLowerCase()
        );
        if (colIndex !== -1 && colIndex < cells.length) {
          if (!cells[colIndex] || cells[colIndex].trim() === "") {
            issues.push({
              line: i + 1,
              type: "empty_cell",
              message: `Empty "${reqCol}" column in test case row`,
            });
          }
        }
      }

      // Validate priority value
      const priorityIndex = headerColumns.findIndex(
        (h) => h.toLowerCase() === "priority"
      );
      if (priorityIndex !== -1 && priorityIndex < cells.length) {
        const priority = cells[priorityIndex].trim();
        if (!VALID_PRIORITIES.has(priority)) {
          issues.push({
            line: i + 1,
            type: "invalid_priority",
            message: `Invalid priority "${priority}" (expected P0, P1, or P2)`,
          });
        }
      }

      // Validate status value if present
      const statusIndex = headerColumns.findIndex(
        (h) => h.toLowerCase() === "status"
      );
      if (statusIndex !== -1 && statusIndex < cells.length) {
        const status = cells[statusIndex].trim();
        if (!VALID_STATUSES.has(status)) {
          issues.push({
            line: i + 1,
            type: "invalid_status",
            message: `Invalid status "${status}" (expected: Not Started, Pass, Fail, Blocked, Skipped)`,
          });
        }
      }

      // Validate ID format
      const idIndex = headerColumns.findIndex(
        (h) => h.toLowerCase() === "id"
      );
      if (idIndex !== -1 && idIndex < cells.length) {
        const id = cells[idIndex].trim();
        if (!ID_STRICT.test(id)) {
          issues.push({
            line: i + 1,
            type: "invalid_id",
            message: `Invalid ID format "${id}" (expected UAT-X.Y.Z)`,
          });
        }
      }
    }

    // Reset when hitting a non-table line (but allow blank lines between table sections)
    if (inTestTable && !line.startsWith("|") && line !== "") {
      inTestTable = false;
      headerColumns = [];
    }
  }

  return issues;
}

function checkIdSequenceGaps(allIds) {
  // Group IDs by module.scenario prefix
  const groups = new Map(); // "M.S" -> [test numbers]
  for (const { id } of allIds) {
    const match = id.match(ID_STRICT);
    if (match) {
      const key = `${match[1]}.${match[2]}`;
      if (!groups.has(key)) groups.set(key, []);
      groups.get(key).push(parseInt(match[3], 10));
    }
  }

  const gaps = [];
  for (const [prefix, tests] of groups) {
    tests.sort((a, b) => a - b);
    for (let i = 0; i < tests.length - 1; i++) {
      if (tests[i + 1] - tests[i] > 1) {
        const missing = [];
        for (let j = tests[i] + 1; j < tests[i + 1]; j++) {
          missing.push(`UAT-${prefix}.${j}`);
        }
        gaps.push({
          prefix: `UAT-${prefix}`,
          missing,
        });
      }
    }
  }
  return gaps;
}

function isCriticalModule(moduleName) {
  const nameLower = moduleName.toLowerCase();
  return CRITICAL_MODULE_KEYWORDS.some((kw) => nameLower.includes(kw));
}

// ---------------------------------------------------------------------------
// Main Validation
// ---------------------------------------------------------------------------

function validate(filePath) {
  const content = readFile(filePath);
  let l1Passed = 0;
  let l1Failed = 0;
  const l1Issues = [];
  let l2Passed = 0;
  let l2Warned = 0;
  const l2Warnings = [];

  console.log(`\nValidating: ${path.basename(filePath)}`);
  console.log("=".repeat(60));
  console.log("\n--- LEVEL 1: Structural Integrity ---\n");

  // =========================================================================
  // LEVEL 1: Structural Integrity (must pass)
  // =========================================================================

  // 1. Check test ID uniqueness
  const allIds = extractAllTestIds(content);
  const idSet = new Set();
  const duplicates = [];
  for (const { id, line } of allIds) {
    if (idSet.has(id)) {
      duplicates.push({ id, line });
    }
    idSet.add(id);
  }

  if (duplicates.length === 0) {
    console.log(`  PASS  All ${idSet.size} test IDs are unique`);
    l1Passed++;
  } else {
    console.log(`  FAIL  ${duplicates.length} duplicate test ID(s) found:`);
    for (const d of duplicates) {
      console.log(`         - ${d.id} at line ${d.line}`);
    }
    l1Failed++;
    l1Issues.push(...duplicates.map((d) => ({
      type: "duplicate_id",
      message: `Duplicate ID ${d.id}`,
      line: d.line,
    })));
  }

  // 2. Check ID format
  const badFormat = allIds.filter(({ id }) => !ID_STRICT.test(id));
  if (badFormat.length === 0) {
    console.log(`  PASS  All test IDs follow UAT-X.Y.Z format`);
    l1Passed++;
  } else {
    console.log(`  FAIL  ${badFormat.length} test ID(s) with invalid format:`);
    for (const b of badFormat) {
      console.log(`         - "${b.id}" at line ${b.line}`);
    }
    l1Failed++;
    l1Issues.push(...badFormat.map((b) => ({
      type: "invalid_id_format",
      message: `Invalid ID format ${b.id}`,
      line: b.line,
    })));
  }

  // 3. Check summary table vs actual counts
  const summary = extractSummaryTable(content);
  const moduleTests = extractModuleTestCases(content);

  if (summary.totals) {
    const actualTotal = allIds.length;
    if (summary.totals.total === actualTotal) {
      console.log(`  PASS  Summary total (${summary.totals.total}) matches actual test cases (${actualTotal})`);
      l1Passed++;
    } else {
      console.log(`  FAIL  Summary total (${summary.totals.total}) does not match actual test cases (${actualTotal})`);
      l1Failed++;
      l1Issues.push({
        type: "count_mismatch",
        message: `Summary total ${summary.totals.total} vs actual ${actualTotal}`,
      });
    }

    // Check P0/P1/P2 totals
    let actualP0 = 0;
    let actualP1 = 0;
    let actualP2 = 0;
    for (const [, mod] of moduleTests) {
      actualP0 += mod.p0;
      actualP1 += mod.p1;
      actualP2 += mod.p2;
    }

    const priorityChecks = [
      { name: "P0", expected: summary.totals.p0, actual: actualP0 },
      { name: "P1", expected: summary.totals.p1, actual: actualP1 },
      { name: "P2", expected: summary.totals.p2, actual: actualP2 },
    ];

    for (const pc of priorityChecks) {
      if (pc.expected === pc.actual) {
        console.log(`  PASS  Summary ${pc.name} count (${pc.expected}) matches actual (${pc.actual})`);
        l1Passed++;
      } else {
        console.log(`  FAIL  Summary ${pc.name} count (${pc.expected}) does not match actual (${pc.actual})`);
        l1Failed++;
        l1Issues.push({
          type: "priority_count_mismatch",
          message: `Summary ${pc.name}: ${pc.expected} vs actual: ${pc.actual}`,
        });
      }
    }
  } else {
    console.log(`  WARN  No summary table found -- skipping count validation`);
  }

  // 4. Check per-module counts against summary
  if (summary.modules.length > 0 && moduleTests.size > 0) {
    let moduleCountMatch = true;
    for (let idx = 0; idx < summary.modules.length; idx++) {
      const sm = summary.modules[idx];
      const mt = moduleTests.get(idx + 1);
      if (mt) {
        if (sm.total !== mt.total) {
          console.log(`  FAIL  Module ${idx + 1} "${sm.name}": summary says ${sm.total} tests, found ${mt.total}`);
          moduleCountMatch = false;
          l1Failed++;
          l1Issues.push({
            type: "module_count_mismatch",
            message: `Module ${idx + 1}: summary ${sm.total} vs actual ${mt.total}`,
          });
        }
        // Also check per-module P0/P1/P2
        if (sm.p0 !== mt.p0 || sm.p1 !== mt.p1 || sm.p2 !== mt.p2) {
          console.log(`  FAIL  Module ${idx + 1} "${sm.name}": priority counts mismatch (Summary: P0=${sm.p0}/P1=${sm.p1}/P2=${sm.p2}, Actual: P0=${mt.p0}/P1=${mt.p1}/P2=${mt.p2})`);
          moduleCountMatch = false;
          l1Failed++;
          l1Issues.push({
            type: "module_priority_mismatch",
            message: `Module ${idx + 1} priority: Summary P0=${sm.p0}/P1=${sm.p1}/P2=${sm.p2} vs Actual P0=${mt.p0}/P1=${mt.p1}/P2=${mt.p2}`,
          });
        }
      }
    }
    if (moduleCountMatch) {
      console.log(`  PASS  All module counts and priority breakdowns match between summary and content`);
      l1Passed++;
    }
  }

  // 5. Check table cells
  const cellIssues = checkTableCells(content);
  const emptyIssues = cellIssues.filter((i) => i.type === "empty_cell");
  const priorityIssues = cellIssues.filter((i) => i.type === "invalid_priority");
  const statusIssues = cellIssues.filter((i) => i.type === "invalid_status");

  if (emptyIssues.length === 0) {
    console.log(`  PASS  No empty required cells found`);
    l1Passed++;
  } else {
    console.log(`  FAIL  ${emptyIssues.length} empty required cell(s):`);
    for (const e of emptyIssues.slice(0, 5)) {
      console.log(`         - Line ${e.line}: ${e.message}`);
    }
    if (emptyIssues.length > 5) {
      console.log(`         ... and ${emptyIssues.length - 5} more`);
    }
    l1Failed++;
    l1Issues.push(...emptyIssues);
  }

  if (priorityIssues.length === 0) {
    console.log(`  PASS  All priority values are valid (P0/P1/P2)`);
    l1Passed++;
  } else {
    console.log(`  FAIL  ${priorityIssues.length} invalid priority value(s):`);
    for (const p of priorityIssues) {
      console.log(`         - Line ${p.line}: ${p.message}`);
    }
    l1Failed++;
    l1Issues.push(...priorityIssues);
  }

  if (statusIssues.length === 0) {
    console.log(`  PASS  All status values are valid`);
    l1Passed++;
  } else {
    console.log(`  FAIL  ${statusIssues.length} invalid status value(s):`);
    for (const s of statusIssues) {
      console.log(`         - Line ${s.line}: ${s.message}`);
    }
    l1Failed++;
    l1Issues.push(...statusIssues);
  }

  // =========================================================================
  // LEVEL 2: Quality Gates (warnings)
  // =========================================================================

  console.log("\n--- LEVEL 2: Quality Gates ---\n");

  // 6. Priority distribution analysis
  if (moduleTests.size > 0) {
    let totalP0 = 0, totalP1 = 0, totalP2 = 0;
    for (const [, mod] of moduleTests) {
      totalP0 += mod.p0;
      totalP1 += mod.p1;
      totalP2 += mod.p2;
    }
    const totalAll = totalP0 + totalP1 + totalP2;

    if (totalAll > 0) {
      const ratioP0 = totalP0 / totalAll;
      const ratioP1 = totalP1 / totalAll;
      const ratioP2 = totalP2 / totalAll;

      const checkPriority = (name, ratio, range) => {
        const pct = (ratio * 100).toFixed(1);
        if (ratio >= range.min && ratio <= range.max) {
          console.log(`  PASS  ${name} distribution: ${pct}% (target: ${range.label})`);
          l2Passed++;
        } else {
          const direction = ratio < range.min ? "too low" : "too high";
          console.log(`  WARN  ${name} distribution: ${pct}% is ${direction} (target: ${range.label})`);
          l2Warned++;
          l2Warnings.push({
            type: "priority_distribution",
            message: `${name} at ${pct}% is outside target range ${range.label}`,
          });
        }
      };

      checkPriority("P0", ratioP0, PRIORITY_RANGES.P0);
      checkPriority("P1", ratioP1, PRIORITY_RANGES.P1);
      checkPriority("P2", ratioP2, PRIORITY_RANGES.P2);
    }
  }

  // 7. Minimum tests per module
  if (moduleTests.size > 0) {
    const thinModules = [];
    for (const [num, mod] of moduleTests) {
      if (mod.total < MIN_TESTS_PER_MODULE) {
        thinModules.push({ num, name: mod.name, count: mod.total });
      }
    }

    if (thinModules.length === 0) {
      console.log(`  PASS  All modules have >= ${MIN_TESTS_PER_MODULE} test cases`);
      l2Passed++;
    } else {
      console.log(`  WARN  ${thinModules.length} module(s) have fewer than ${MIN_TESTS_PER_MODULE} test cases:`);
      for (const tm of thinModules) {
        console.log(`         - Module ${tm.num} "${tm.name}": ${tm.count} test cases`);
      }
      l2Warned++;
      l2Warnings.push(...thinModules.map((tm) => ({
        type: "thin_module",
        message: `Module ${tm.num} "${tm.name}" has only ${tm.count} tests (min: ${MIN_TESTS_PER_MODULE})`,
      })));
    }
  }

  // 8. Critical module P0 concentration check
  if (moduleTests.size > 0) {
    const criticalIssues = [];
    for (const [num, mod] of moduleTests) {
      if (isCriticalModule(mod.name) && mod.total > 0) {
        const p0Ratio = mod.p0 / mod.total;
        if (p0Ratio < CRITICAL_MODULE_MIN_P0_RATIO) {
          criticalIssues.push({
            num,
            name: mod.name,
            p0Ratio: (p0Ratio * 100).toFixed(1),
            p0Count: mod.p0,
            total: mod.total,
          });
        }
      }
    }

    if (criticalIssues.length === 0) {
      console.log(`  PASS  All critical modules have adequate P0 concentration (>= ${(CRITICAL_MODULE_MIN_P0_RATIO * 100)}%)`);
      l2Passed++;
    } else {
      console.log(`  WARN  ${criticalIssues.length} critical module(s) with low P0 concentration:`);
      for (const ci of criticalIssues) {
        console.log(`         - Module ${ci.num} "${ci.name}": P0 is ${ci.p0Ratio}% (${ci.p0Count}/${ci.total}), target >= ${(CRITICAL_MODULE_MIN_P0_RATIO * 100)}%`);
      }
      l2Warned++;
      l2Warnings.push(...criticalIssues.map((ci) => ({
        type: "critical_module_low_p0",
        message: `Module ${ci.num} "${ci.name}" P0 at ${ci.p0Ratio}% is below ${(CRITICAL_MODULE_MIN_P0_RATIO * 100)}% target`,
      })));
    }
  }

  // 9. Coverage traceability cross-reference
  const traceability = extractTraceabilityIds(content);
  if (traceability.requirements.length > 0) {
    // Check for phantom IDs (referenced in traceability but not found in any module)
    const actualIdSet = new Set(allIds.map(({ id }) => id));
    const phantomIds = [];
    for (const id of traceability.referencedIds) {
      if (!actualIdSet.has(id)) {
        phantomIds.push(id);
      }
    }

    if (phantomIds.length === 0) {
      console.log(`  PASS  All ${traceability.referencedIds.size} traceability IDs reference actual test cases`);
      l2Passed++;
    } else {
      console.log(`  WARN  ${phantomIds.length} phantom ID(s) in traceability matrix (not found in test cases):`);
      for (const pid of phantomIds.slice(0, 10)) {
        console.log(`         - ${pid}`);
      }
      if (phantomIds.length > 10) {
        console.log(`         ... and ${phantomIds.length - 10} more`);
      }
      l2Warned++;
      l2Warnings.push(...phantomIds.map((pid) => ({
        type: "phantom_traceability_id",
        message: `Traceability references ${pid} which does not exist as a test case`,
      })));
    }

    // Check for orphaned test IDs (exist in modules but never referenced in traceability)
    const orphanedIds = [];
    for (const id of actualIdSet) {
      if (!traceability.referencedIds.has(id)) {
        orphanedIds.push(id);
      }
    }

    if (orphanedIds.length === 0) {
      console.log(`  PASS  All test cases are referenced in the traceability matrix`);
      l2Passed++;
    } else {
      const orphanPct = ((orphanedIds.length / actualIdSet.size) * 100).toFixed(1);
      console.log(`  WARN  ${orphanedIds.length} test case(s) (${orphanPct}%) not referenced in traceability matrix:`);
      for (const oid of orphanedIds.slice(0, 10)) {
        console.log(`         - ${oid}`);
      }
      if (orphanedIds.length > 10) {
        console.log(`         ... and ${orphanedIds.length - 10} more`);
      }
      l2Warned++;
      l2Warnings.push({
        type: "orphaned_test_ids",
        message: `${orphanedIds.length} test case(s) not referenced in traceability matrix`,
      });
    }

    // Check for "Gap" requirements without recommendation
    const gapReqs = traceability.requirements.filter(
      (r) => /gap/i.test(r.status) && r.testIds.length === 0
    );
    if (gapReqs.length > 0) {
      console.log(`  INFO  ${gapReqs.length} requirement(s) marked as "Gap" in traceability matrix:`);
      for (const gr of gapReqs) {
        console.log(`         - ${gr.reqId}: ${gr.description}`);
      }
      // This is informational, not a warning -- gaps are expected and should be in gap analysis
    }
  } else {
    console.log(`  WARN  No coverage traceability matrix found`);
    l2Warned++;
    l2Warnings.push({
      type: "missing_traceability",
      message: "No coverage traceability matrix found in the document",
    });
  }

  // 10. ID sequence gap detection
  const idGaps = checkIdSequenceGaps(allIds);
  if (idGaps.length === 0) {
    console.log(`  PASS  No sequential ID gaps detected`);
    l2Passed++;
  } else {
    console.log(`  WARN  Sequential ID gaps detected in ${idGaps.length} scenario(s):`);
    for (const gap of idGaps.slice(0, 10)) {
      console.log(`         - ${gap.prefix}.* missing: ${gap.missing.join(", ")}`);
    }
    if (idGaps.length > 10) {
      console.log(`         ... and ${idGaps.length - 10} more`);
    }
    l2Warned++;
    l2Warnings.push(...idGaps.map((g) => ({
      type: "id_gap",
      message: `Gap in ${g.prefix}: missing ${g.missing.join(", ")}`,
    })));
  }

  // =========================================================================
  // Report
  // =========================================================================

  console.log("\n" + "=".repeat(60));
  console.log("RESULTS");
  console.log("=".repeat(60));

  console.log(`\nLevel 1 (Structural): ${l1Passed} passed, ${l1Failed} failed`);
  console.log(`Level 2 (Quality):    ${l2Passed} passed, ${l2Warned} warning(s)`);
  console.log(`Test Cases:           ${idSet.size} unique IDs found`);

  if (moduleTests.size > 0) {
    let tp0 = 0, tp1 = 0, tp2 = 0;
    for (const [, mod] of moduleTests) {
      tp0 += mod.p0;
      tp1 += mod.p1;
      tp2 += mod.p2;
    }
    const total = tp0 + tp1 + tp2;
    if (total > 0) {
      console.log(`Priority Distribution: P0: ${tp0} (${((tp0 / total) * 100).toFixed(1)}%), P1: ${tp1} (${((tp1 / total) * 100).toFixed(1)}%), P2: ${tp2} (${((tp2 / total) * 100).toFixed(1)}%)`);
    }
    console.log(`Modules:              ${moduleTests.size} detected`);

    // Per-module summary
    console.log(`\nPer-Module Breakdown:`);
    for (const [num, mod] of moduleTests) {
      const criticalTag = isCriticalModule(mod.name) ? " [CRITICAL]" : "";
      const p0Pct = mod.total > 0 ? ((mod.p0 / mod.total) * 100).toFixed(0) : 0;
      console.log(`  Module ${num}: ${mod.name}${criticalTag} -- ${mod.total} tests (P0: ${mod.p0}/${p0Pct}%, P1: ${mod.p1}, P2: ${mod.p2})`);
    }
  }

  // Final verdict
  if (l1Failed === 0 && l2Warned === 0) {
    console.log("\n  Validation PASSED (Level 1 + Level 2)\n");
    return 0;
  } else if (l1Failed === 0) {
    console.log(`\n  Validation PASSED with ${l2Warned} quality warning(s)\n`);
    if (l2Warnings.length > 0) {
      console.log("  Quality warnings to address:");
      for (const w of l2Warnings) {
        console.log(`    - [${w.type}] ${w.message}`);
      }
      console.log("");
    }
    return 2;
  } else {
    console.log(`\n  Validation FAILED (${l1Failed} structural error(s))\n`);
    if (l1Issues.length > 0) {
      console.log("  Errors to fix:");
      for (const issue of l1Issues.slice(0, 20)) {
        const lineInfo = issue.line ? ` (line ${issue.line})` : "";
        console.log(`    - [${issue.type}] ${issue.message}${lineInfo}`);
      }
      if (l1Issues.length > 20) {
        console.log(`    ... and ${l1Issues.length - 20} more`);
      }
      console.log("");
    }
    return 1;
  }
}

// ---------------------------------------------------------------------------
// CLI
// ---------------------------------------------------------------------------

const args = process.argv.slice(2);
if (args.length === 0) {
  console.log("Usage: node validate-uat.js <UAT-file.md>");
  console.log("       node validate-uat.js UAT-MyProject.md");
  console.log("");
  console.log("Exit codes:");
  console.log("  0 = All checks passed (Level 1 + Level 2)");
  console.log("  1 = Level 1 failure (structural integrity)");
  console.log("  2 = Level 1 passed, Level 2 warnings exist");
  process.exit(1);
}

const exitCode = validate(args[0]);
process.exit(exitCode);
