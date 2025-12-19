USE TRASAR3 --Database Name

BEGIN TRY
    BEGIN TRANSACTION

    --enter your DML Queries here like insert, update, delete

    COMMIT TRANSACTION
    PRINT 'Transaction Commited'
END TRY
BEGIN CATCH
    SELECT   
        ERROR_NUMBER() AS ErrorNumber,  
	   ERROR_SEVERITY() AS ErrorSeverity,
	   ERROR_LINE() AS ErrorLine,  
	   ERROR_MESSAGE() AS ErrorMessage; 
    ROLLBACK
    PRINT 'Transaction Rolled Back'
END CATCH
