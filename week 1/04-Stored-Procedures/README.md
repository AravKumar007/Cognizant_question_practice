# Exercise 4 - Stored Procedures (Employee Management System)

11 stand-alone exercises covering procedure creation, modification, deletion,
execution, output parameters, conditional logic, transactions, dynamic SQL,
and error handling.

## Run order
1. `00_Schema.sql`
2. `01_sp_InsertEmployee.sql`
3. `02_ModifySP_AddSalary.sql`
4. `03_DropProcedure.sql` (drops `sp_InsertEmployee` from step 2)
5. `04_ExecuteProcedure.sql`
6. `05_sp_GetEmployeeCountByDepartment.sql`
7. `06_sp_GetTotalSalaryByDepartment_Output.sql`
8. `07_sp_UpdateEmployeeSalary.sql`
9. `08_sp_GiveBonus.sql`
10. `09_sp_UpdateEmployeeSalary_Transaction.sql`
11. `10_sp_DynamicSQLFilter.sql`
12. `11_sp_UpdateEmployeeSalary_ErrorHandling.sql`

## Notes
- `03_DropProcedure.sql` intentionally removes `sp_InsertEmployee` per the
  exercise instructions — run the folder top to bottom in order.
- `10_sp_DynamicSQLFilter.sql` whitelists filterable columns and uses
  `sp_executesql` with a parameter instead of string-concatenating the
  filter value, to avoid SQL injection.
