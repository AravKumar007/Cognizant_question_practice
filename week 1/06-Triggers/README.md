# Exercise 6 - Triggers (Employee Management System)

Covers AFTER triggers, INSTEAD OF triggers, LOGON triggers, modifying
triggers, deleting triggers, and using a trigger to maintain a computed
column.

## Run order
1. `00_Schema.sql`
2. `01_AfterTrigger_LogSalaryChanges.sql` - logs every salary change into
   `EmployeeChanges`.
3. `02_InsteadOfTrigger_PreventDelete.sql` - blocks `DELETE` on `Employees`.
4. `03_LogonTrigger_MaintenanceWindow.sql` - server-level LOGON trigger,
   blocks new connections between 2 AM and 3 AM. **Server-scoped, not
   database-scoped** - see the warning in the script before running it
   anywhere other than a personal/test instance.
5. `04_ModifyTrigger_SSMS.sql` - the SSMS "Modify" workflow, plus an actual
   `ALTER TRIGGER` that extends `trg_LogSalaryChange` to capture who made
   the change.
6. `05_DeleteTrigger.sql` - drops `trg_PreventEmployeeDelete`.
7. `06_ComputedColumnTrigger_AnnualSalary.sql` - keeps an `AnnualSalary`
   column in sync with `Salary` on every update.

## Notes
- `03_LogonTrigger_MaintenanceWindow.sql` operates on `ALL SERVER`, so it
  affects every database on the instance, not just `EmployeeManagementDB`.
  Test it carefully and keep a way to disable it (e.g. Dedicated Admin
  Connection) before running it anywhere important.
