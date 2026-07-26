# Exercise 3 - Views (Employee Management System)

Covers creating views with joins and computed columns.

## Run order
1. `00_Schema.sql` - creates `EmployeeManagementDB` and seeds Departments/Employees.
2. `01_vw_EmployeeBasicInfo.sql` - basic employee + department view.
3. `02_vw_EmployeeFullName.sql` - adds a computed `FullName` column.
4. `03_vw_EmployeeAnnualSalary.sql` - adds a computed `AnnualSalary` column.
5. `04_vw_EmployeeReport.sql` - combines FullName, DepartmentName, AnnualSalary,
   and a 10% Bonus into one report view.

## Notes
- Each script drops and recreates its view so it can be re-run without errors.
