# Exercise 8 - Exception Handling (Employee Management System)

Covers TRY...CATCH, THROW, RAISERROR (including severity/state), nested
error handling, and transactional batch inserts with rollback.

## Run order
1. `00_Schema.sql` - schema + `AuditLog` table + `Email` column on Employees.
2. `01_AddEmployee_TryCatch.sql` - basic TRY...CATCH, logs failures to `AuditLog`.
3. `02_AddEmployee_Throw.sql` - logs the error, then `THROW`s it back to the caller.
4. `03_AddEmployee_RaiseError_SalaryValidation.sql` - rejects Salary <= 0
   with `RAISERROR` before attempting the insert.
5. `04_TransferEmployee_NestedTryCatch.sql` - nested TRY...CATCH; inner
   block logs and re-raises, outer block is the final safety net.
6. `05_BatchInsertEmployees_Transaction.sql` - table-valued parameter +
   transaction; any failure rolls back the entire batch, not just the bad row.
7. `06_AddEmployee_DynamicRaiseError.sql` - severity 10 warning for a very
   low salary, severity 16 hard error for a negative salary.

## Notes
- Every procedure logs failures into `AuditLog` before surfacing the error,
  so you get both a permanent record and normal error propagation to the caller.
- `05_BatchInsertEmployees_Transaction.sql` uses a user-defined table type
  (`EmployeeBatchType`) so a whole list of employees can be passed into the
  stored procedure and inserted as a single all-or-nothing transaction.
