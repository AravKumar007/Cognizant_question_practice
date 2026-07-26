# Exercise 5 - Functions (Employee Management System)

Covers scalar functions, table-valued functions, altering/dropping
functions, and nested functions.

## Run order
1. `00_Schema.sql` - this exercise uses its own department numbering
   (HR=1, IT=2, Finance=3) matching the original sheet.
2. `01_fn_CalculateAnnualSalary.sql`
3. `02_fn_GetEmployeesByDepartment.sql`
4. `03_fn_CalculateBonus.sql`
5. `04_AlterBonusFunction.sql` (bonus rate 10% -> 15%)
6. `05_DropBonusFunction.sql`
7. `06_ExecuteAnnualSalaryFunction.sql`
8. `07_AnnualSalaryForEmployee1.sql`
9. `08_GetEmployeesFinanceDept.sql`
10. `09_fn_CalculateTotalCompensation.sql` (recreates `fn_CalculateBonus` at
    10% since step 6 dropped it, then builds the nested function on top)
11. `10_ModifyNestedFunction.sql` (bonus rate bumped to 20%, showing the
    nested function picks up the change automatically)

## Notes
- The department IDs in this folder intentionally differ from the Views/
  Stored Procedures/Triggers folders because the original exercise sheet
  numbered them differently (HR=1, IT=2, Finance=3 here).
