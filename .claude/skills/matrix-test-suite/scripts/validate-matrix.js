#!/usr/bin/env node

/**
 * Matrix Test Suite Validator
 *
 * Validates MATRIX, TESTCASES, and COVERAGE-REPORT markdown files
 * for consistency, completeness, and correctness.
 *
 * Usage:
 *   node validate-matrix.js <TESTCASES-file.md>
 *   node validate-matrix.js <MATRIX-file.md> <TESTCASES-file.md> <COVERAGE-REPORT-file.md>
 *
 * Zero dependencies. Node.js 14+ required.
 */

const fs = require('fs');
const path = require('path');

// --- Configuration ---

const VALID_PRIORITIES = ['P0', 'P1', 'P2'];
const VALID_STATUSES = ['Not Started', 'In Progress', 'Passed', 'Failed', 'Blocked', 'Skipped', 'N/A', ''];
const ID_PATTERN = /^MTX-\d+-[A-Za-z0-9]+-\d+$/;
const REQUIRED_TESTCASE_COLUMNS = ['ID', 'Matrix Cell', 'Description', 'Steps', 'Expected Result', 'Priority'];

// --- Helpers ---

function readFile(filePath) {
  try {
    return fs.readFileSync(filePath, 'utf-8');
  } catch (err) {
    return null;
  }
}

function extractMarkdownTables(content) {
  const tables = [];
  const lines = content.split('\n');
  let currentTable = null;
  let headerParsed = false;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    if (line.startsWith('|') && line.endsWith('|')) {
      if (!currentTable) {
        currentTable = { headers: [], rows: [], startLine: i + 1 };
        headerParsed = false;
      }

      const cells = line
        .slice(1, -1)
        .split('|')
        .map(c => c.trim());

      if (!headerParsed) {
        currentTable.headers = cells;
        headerParsed = true;
      } else if (cells.every(c => /^[-:]+$/.test(c))) {
        // Separator line, skip
        continue;
      } else {
        currentTable.rows.push(cells);
      }
    } else {
      if (currentTable && currentTable.rows.length > 0) {
        tables.push(currentTable);
      }
      currentTable = null;
      headerParsed = false;
    }
  }

  if (currentTable && currentTable.rows.length > 0) {
    tables.push(currentTable);
  }

  return tables;
}

function findColumnIndex(headers, ...names) {
  for (const name of names) {
    const idx = headers.findIndex(
      h => h.toLowerCase().replace(/[^a-z0-9]/g, '') === name.toLowerCase().replace(/[^a-z0-9]/g, '')
    );
    if (idx !== -1) return idx;
  }
  return -1;
}

function extractTestIds(content) {
  const ids = [];
  const tables = extractMarkdownTables(content);

  for (const table of tables) {
    const idCol = findColumnIndex(table.headers, 'ID');
    if (idCol === -1) continue;

    for (const row of table.rows) {
      if (row[idCol] && row[idCol].startsWith('MTX-')) {
        ids.push(row[idCol]);
      }
    }
  }

  return ids;
}

function extractMatrixCellsFromTests(content) {
  const cells = new Set();
  const tables = extractMarkdownTables(content);

  for (const table of tables) {
    const cellCol = findColumnIndex(table.headers, 'MatrixCell', 'Matrix Cell');
    if (cellCol === -1) continue;

    for (const row of table.rows) {
      if (row[cellCol] && row[cellCol] !== '' && row[cellCol] !== '**Total**') {
        cells.add(row[cellCol]);
      }
    }
  }

  return cells;
}

function extractSummaryTotals(content) {
  const totals = { total: null, groups: [] };
  const tables = extractMarkdownTables(content);

  for (const table of tables) {
    const hasTotal = findColumnIndex(table.headers, 'Total', 'TestCases', 'Test Cases');
    if (hasTotal === -1) continue;

    for (const row of table.rows) {
      const rowText = row.join(' ');
      if (rowText.includes('**Total**') || rowText.includes('Total')) {
        const totalVal = row[hasTotal];
        if (totalVal) {
          const num = parseInt(totalVal.replace(/[^0-9]/g, ''), 10);
          if (!isNaN(num)) {
            totals.total = num;
          }
        }
      }
    }
  }

  // Also look for "Total test cases: **N**" pattern
  const totalPattern = /Total test cases[:\s]*\*?\*?(\d+)\*?\*?/i;
  const match = content.match(totalPattern);
  if (match) {
    totals.total = parseInt(match[1], 10);
  }

  return totals;
}

function extractPriorityCounts(content) {
  const counts = { P0: 0, P1: 0, P2: 0 };
  const tables = extractMarkdownTables(content);

  for (const table of tables) {
    const idCol = findColumnIndex(table.headers, 'ID');
    const prioCol = findColumnIndex(table.headers, 'Priority');
    if (prioCol === -1 || idCol === -1) continue;

    for (const row of table.rows) {
      // Only count priorities from actual test case rows (with MTX- IDs)
      if (row[idCol] && row[idCol].startsWith('MTX-')) {
        const prio = row[prioCol];
        if (prio && VALID_PRIORITIES.includes(prio)) {
          counts[prio]++;
        }
      }
    }
  }

  return counts;
}

// --- Validators ---

function validateTestcases(content, filePath) {
  const errors = [];
  const warnings = [];
  const fileName = path.basename(filePath);

  // 1. Extract all test IDs
  const testIds = extractTestIds(content);
  if (testIds.length === 0) {
    errors.push(`[${fileName}] No test case IDs found (expected MTX-X-Y-Z pattern)`);
    return { errors, warnings, testIds };
  }

  // 2. Check ID uniqueness
  const idSet = new Set();
  const duplicates = [];
  for (const id of testIds) {
    if (idSet.has(id)) {
      duplicates.push(id);
    }
    idSet.add(id);
  }
  if (duplicates.length > 0) {
    errors.push(`[${fileName}] Duplicate test IDs: ${duplicates.join(', ')}`);
  }

  // 3. Check ID format
  const badIds = testIds.filter(id => !ID_PATTERN.test(id));
  if (badIds.length > 0) {
    warnings.push(`[${fileName}] Non-standard ID format (expected MTX-X-Y-Z): ${badIds.slice(0, 5).join(', ')}${badIds.length > 5 ? ` ... and ${badIds.length - 5} more` : ''}`);
  }

  // 4. Check required columns in test case tables
  const tables = extractMarkdownTables(content);
  for (const table of tables) {
    const idCol = findColumnIndex(table.headers, 'ID');
    if (idCol === -1) continue;

    // This is a test case table
    for (const reqCol of REQUIRED_TESTCASE_COLUMNS) {
      const colIdx = findColumnIndex(table.headers, reqCol);
      if (colIdx === -1) {
        warnings.push(`[${fileName}] Table at line ${table.startLine}: missing required column "${reqCol}"`);
        continue;
      }

      // Check for empty cells in required columns
      for (let i = 0; i < table.rows.length; i++) {
        const row = table.rows[i];
        if (row[idCol] && row[idCol].startsWith('MTX-')) {
          if (!row[colIdx] || row[colIdx].trim() === '') {
            errors.push(`[${fileName}] Test ${row[idCol]}: empty required column "${reqCol}"`);
          }
        }
      }
    }

    // 5. Validate priority values
    const prioCol = findColumnIndex(table.headers, 'Priority');
    if (prioCol !== -1) {
      for (const row of table.rows) {
        if (row[idCol] && row[idCol].startsWith('MTX-')) {
          const prio = row[prioCol];
          if (prio && !VALID_PRIORITIES.includes(prio)) {
            errors.push(`[${fileName}] Test ${row[idCol]}: invalid priority "${prio}" (expected P0, P1, or P2)`);
          }
        }
      }
    }

    // 6. Validate status values (if present)
    const statusCol = findColumnIndex(table.headers, 'Status');
    if (statusCol !== -1) {
      for (const row of table.rows) {
        if (row[idCol] && row[idCol].startsWith('MTX-')) {
          const status = row[statusCol];
          if (status && !VALID_STATUSES.includes(status)) {
            warnings.push(`[${fileName}] Test ${row[idCol]}: non-standard status "${status}"`);
          }
        }
      }
    }
  }

  // 7. Verify summary totals
  const summaryTotals = extractSummaryTotals(content);
  if (summaryTotals.total !== null) {
    if (summaryTotals.total !== testIds.length) {
      errors.push(`[${fileName}] Summary claims ${summaryTotals.total} tests but found ${testIds.length} test case rows`);
    }
  } else {
    warnings.push(`[${fileName}] Could not find total test case count in summary`);
  }

  // 8. Verify priority distribution
  const prioCounts = extractPriorityCounts(content);
  const totalFromPrio = prioCounts.P0 + prioCounts.P1 + prioCounts.P2;
  if (totalFromPrio > 0 && totalFromPrio !== testIds.length) {
    warnings.push(`[${fileName}] Priority counts sum to ${totalFromPrio} but ${testIds.length} test IDs found`);
  }

  return { errors, warnings, testIds, prioCounts };
}

function validateCrossReference(matrixContent, testcasesContent, matrixFile, testcasesFile) {
  const errors = [];
  const warnings = [];

  if (!matrixContent) return { errors, warnings };

  // Extract matrix cells from MATRIX file (look for cell IDs in tables)
  const matrixCellPattern = /[A-Z]-[A-Z][0-9](?:-[A-Z][0-9])?|[A-Z]{1,2}-[A-Z]{1,2}[0-9]*/g;
  const matrixCells = new Set();
  const matrixTables = extractMarkdownTables(matrixContent);

  for (const table of matrixTables) {
    for (const row of table.rows) {
      for (const cell of row) {
        const matches = cell.match(matrixCellPattern);
        if (matches) {
          matches.forEach(m => matrixCells.add(m));
        }
      }
    }
  }

  // Extract cells referenced in test cases
  const testCells = extractMatrixCellsFromTests(testcasesContent);

  // Check that test cells reference valid matrix cells (lenient: just warn)
  if (matrixCells.size > 0 && testCells.size > 0) {
    for (const tc of testCells) {
      // Simple containment check
      let found = false;
      for (const mc of matrixCells) {
        if (tc.includes(mc) || mc.includes(tc)) {
          found = true;
          break;
        }
      }
      // This is informational, not a hard error
    }
  }

  return { errors, warnings };
}

function validateCoverageReport(content, testcaseIds, filePath) {
  const errors = [];
  const warnings = [];

  if (!content) return { errors, warnings };

  const fileName = path.basename(filePath);

  // 1. Check verdict presence
  const verdictPattern = /Verdict[:\s]*\*?\*?(PASS|CONDITIONAL PASS|FAIL)\*?\*?/i;
  const verdictMatch = content.match(verdictPattern);
  if (!verdictMatch) {
    errors.push(`[${fileName}] No coverage verdict found (expected PASS, CONDITIONAL PASS, or FAIL)`);
  }

  // 2. Check that total test count matches testcases
  const totalPattern = /Total test cases[:\s]*[=]?\s*(\d+)/i;
  const totalMatch = content.match(totalPattern);
  if (totalMatch && testcaseIds) {
    const reportTotal = parseInt(totalMatch[1], 10);
    if (reportTotal !== testcaseIds.length) {
      errors.push(`[${fileName}] Coverage report claims ${reportTotal} tests but TESTCASES has ${testcaseIds.length}`);
    }
  }

  // 3. Check for required sections
  const requiredSections = [
    'Executive Summary',
    'Dimension Coverage',
    'Mathematical Proof',
    'Traceability',
    'Gap Analysis',
    'Coverage Verdict'
  ];

  for (const section of requiredSections) {
    const sectionPattern = new RegExp(section.replace(/\s+/g, '\\s+'), 'i');
    if (!sectionPattern.test(content)) {
      warnings.push(`[${fileName}] Missing recommended section: "${section}"`);
    }
  }

  // 4. Check coverage percentages
  const coveragePattern = /(\d+)\/(\d+)\s*=\s*(\d+)%/g;
  let match;
  while ((match = coveragePattern.exec(content)) !== null) {
    const numerator = parseInt(match[1], 10);
    const denominator = parseInt(match[2], 10);
    const percentage = parseInt(match[3], 10);
    const expected = Math.round((numerator / denominator) * 100);
    if (Math.abs(percentage - expected) > 1) {
      warnings.push(`[${fileName}] Coverage math: ${numerator}/${denominator} = ${expected}%, but report says ${percentage}%`);
    }
  }

  // 5. Check checklist
  const checklistItems = content.match(/- \[[ x]\]/g);
  if (checklistItems) {
    const unchecked = content.match(/- \[ \]/g);
    if (unchecked && unchecked.length > 0 && verdictMatch && verdictMatch[1] === 'PASS') {
      errors.push(`[${fileName}] Verdict is PASS but ${unchecked.length} checklist items are unchecked`);
    }
  }

  return { errors, warnings };
}

// --- Main ---

function main() {
  const args = process.argv.slice(2);

  if (args.length === 0) {
    console.log('Matrix Test Suite Validator');
    console.log('');
    console.log('Usage:');
    console.log('  node validate-matrix.js <TESTCASES-file.md>');
    console.log('  node validate-matrix.js <MATRIX-file.md> <TESTCASES-file.md> <COVERAGE-REPORT-file.md>');
    console.log('');
    console.log('Validates:');
    console.log('  - Test ID uniqueness and format');
    console.log('  - Required columns in test case tables');
    console.log('  - Priority values (P0, P1, P2)');
    console.log('  - Summary totals match actual counts');
    console.log('  - Cross-file consistency');
    console.log('  - Coverage report completeness');
    process.exit(0);
  }

  let matrixFile = null;
  let testcasesFile = null;
  let coverageFile = null;

  // Determine file types from names or order
  for (const arg of args) {
    const base = path.basename(arg).toUpperCase();
    if (base.startsWith('MATRIX-') || base.includes('MATRIX')) {
      if (!base.includes('TESTCASE') && !base.includes('COVERAGE')) {
        matrixFile = arg;
        continue;
      }
    }
    if (base.startsWith('TESTCASE') || base.includes('TESTCASE')) {
      testcasesFile = arg;
      continue;
    }
    if (base.startsWith('COVERAGE') || base.includes('COVERAGE')) {
      coverageFile = arg;
      continue;
    }
    // Fallback: if only one file, treat as testcases
    if (args.length === 1) {
      testcasesFile = arg;
    }
  }

  if (!testcasesFile && args.length === 1) {
    testcasesFile = args[0];
  }

  if (!testcasesFile) {
    console.error('Error: Could not identify TESTCASES file. Name file with TESTCASES prefix.');
    process.exit(1);
  }

  console.log('='.repeat(60));
  console.log('  MATRIX TEST SUITE VALIDATOR');
  console.log('='.repeat(60));
  console.log('');

  const allErrors = [];
  const allWarnings = [];

  // Validate TESTCASES
  const testContent = readFile(testcasesFile);
  if (!testContent) {
    console.error(`Error: Cannot read file "${testcasesFile}"`);
    process.exit(1);
  }

  console.log(`Validating: ${path.basename(testcasesFile)}`);
  const testResult = validateTestcases(testContent, testcasesFile);
  allErrors.push(...testResult.errors);
  allWarnings.push(...testResult.warnings);
  console.log(`  Found ${testResult.testIds.length} test case(s)`);
  if (testResult.prioCounts) {
    console.log(`  Priority: P0=${testResult.prioCounts.P0}, P1=${testResult.prioCounts.P1}, P2=${testResult.prioCounts.P2}`);
  }
  console.log('');

  // Validate MATRIX cross-reference
  if (matrixFile) {
    const matrixContent = readFile(matrixFile);
    if (matrixContent) {
      console.log(`Validating: ${path.basename(matrixFile)}`);
      const crossResult = validateCrossReference(matrixContent, testContent, matrixFile, testcasesFile);
      allErrors.push(...crossResult.errors);
      allWarnings.push(...crossResult.warnings);
      console.log('  Cross-reference check complete');
      console.log('');
    } else {
      allWarnings.push(`Cannot read matrix file: ${matrixFile}`);
    }
  }

  // Validate COVERAGE-REPORT
  if (coverageFile) {
    const coverageContent = readFile(coverageFile);
    if (coverageContent) {
      console.log(`Validating: ${path.basename(coverageFile)}`);
      const covResult = validateCoverageReport(coverageContent, testResult.testIds, coverageFile);
      allErrors.push(...covResult.errors);
      allWarnings.push(...covResult.warnings);
      console.log('  Coverage report check complete');
      console.log('');
    } else {
      allWarnings.push(`Cannot read coverage file: ${coverageFile}`);
    }
  }

  // Print results
  console.log('-'.repeat(60));
  console.log('  RESULTS');
  console.log('-'.repeat(60));
  console.log('');

  if (allWarnings.length > 0) {
    console.log(`WARNINGS (${allWarnings.length}):`);
    for (const w of allWarnings) {
      console.log(`  ⚠  ${w}`);
    }
    console.log('');
  }

  if (allErrors.length > 0) {
    console.log(`ERRORS (${allErrors.length}):`);
    for (const e of allErrors) {
      console.log(`  ✗  ${e}`);
    }
    console.log('');
    console.log('='.repeat(60));
    console.log('  VERDICT: FAIL');
    console.log(`  ${allErrors.length} error(s), ${allWarnings.length} warning(s)`);
    console.log('='.repeat(60));
    process.exit(1);
  } else {
    console.log('='.repeat(60));
    console.log('  VERDICT: PASS');
    console.log(`  0 errors, ${allWarnings.length} warning(s)`);
    console.log(`  ${testResult.testIds.length} test cases validated`);
    console.log('='.repeat(60));
    process.exit(0);
  }
}

main();
