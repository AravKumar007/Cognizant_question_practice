/* =========================================================================
   Exercise 3: Create a LOGON Trigger
   Goal: Block new logins during a nightly maintenance window (2 AM - 3 AM).

   NOTE: LOGON triggers are server-scoped (not per-database) and need
   VIEW SERVER STATE permission to create. Run this in its own session on
   a non-production instance, since a mistake here can lock out logins,
   including your own - keep a DAC (Dedicated Admin Connection) handy in
   case you need to disable it.
   ========================================================================= */

USE master;
GO

IF EXISTS (SELECT 1 FROM sys.server_triggers WHERE name = 'trg_BlockLoginsDuringMaintenance')
    DROP TRIGGER trg_BlockLoginsDuringMaintenance ON ALL SERVER;
GO

CREATE TRIGGER trg_BlockLoginsDuringMaintenance
ON ALL SERVER
FOR LOGON
AS
BEGIN
    DECLARE @CurrentHour INT = DATEPART(HOUR, GETDATE());

    IF @CurrentHour = 2  -- maintenance window: 2:00 AM - 2:59 AM
    BEGIN
        ROLLBACK;
        RAISERROR('Logins are disabled during the nightly maintenance window (2 AM - 3 AM).', 16, 1);
    END
END;
GO

-- To remove the trigger later (e.g. after testing):
-- DROP TRIGGER trg_BlockLoginsDuringMaintenance ON ALL SERVER;
