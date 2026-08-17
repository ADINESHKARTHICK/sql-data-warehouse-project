/*
=======================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=======================================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the BULK INSERT command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC beonze.load_bronze
=======================================================================
*/

--create stored procedure
create or alter procedure bronze.load_bronze as
begin
	Declare @start_time datetime,@end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
	begin try
		set @batch_start_time=getdate();
		print'====================================================================================';
		print 'Loading Bronze Layer';
		print'====================================================================================';

		print'------------------------------------------------------------------------------------';
		print'Loading CRM Tables';
		print'------------------------------------------------------------------------------------';
		--crm customer table
		set @start_time=getdate();
		print '>>> Truncating table: bronze.crm_cust_info'
		truncate table bronze.crm_cust_info;
		print '>>> Inserting Data Into: bronze.crm_cust_info'
		bulk insert bronze.crm_cust_info
		from 'C:\Users\ELCOT\Downloads\Videos\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=getdate();
		print'>>>Load Duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+'Seconds';
		print'>>> --------------';

		--crm product table
		set @start_time=getdate();
		print '>>> Truncating table: bronze.cmd_prd_info'
		truncate table bronze.cmd_prd_info;
		print '>>> Inserting Data Into: bronze.cmd_prd_info'
		bulk insert bronze.cmd_prd_info
		from 'C:\Users\ELCOT\Downloads\Videos\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=getdate();
		print'>>>Load Duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+'Seconds';
		print'>>> --------------';

		--crm sales table
		set @start_time=getdate();
		print '>>> Truncating table: bronze.crm_sales_details'
		truncate table bronze.crm_sales_details;
		print '>>> Inserting Data Into: bronze.crm_sales_details'
		bulk insert bronze.crm_sales_details
		from 'C:\Users\ELCOT\Downloads\Videos\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=getdate();
		print'>>>Load Duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+'Seconds';
		print'>>> --------------';

		print'------------------------------------------------------------------------------------';
		print'Loading ERP Tables';
		print'------------------------------------------------------------------------------------';

		--erp loc a101
		set @start_time=getdate();
		print '>>> Truncating table: bronze.erp_loc_a101'
		truncate table bronze.erp_loc_a101;
		print '>>> Inserting Data Into: bronze.erp_loc_a101'
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\ELCOT\Downloads\Videos\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=getdate();
		print'>>>Load Duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+'Seconds';
		print'>>> --------------';

		--erp az12
		set @start_time=getdate();
		print '>>> Truncating table: bronze.erp_cust_az12'
		truncate table bronze.erp_cust_az12;
		print '>>> Inserting Data Into: bronze.erp_cust_az12'
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\ELCOT\Downloads\Videos\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=getdate();
		print'>>>Load Duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+'Seconds';
		print'>>> --------------';

		--erp g1v2
		set @start_time=getdate();
		print '>>> Truncating table: bronze.erp_px_cat_g1v2'
		truncate table bronze.erp_px_cat_g1v2;
		print '>>> Inserting Data Into: bronze.erp_px_cat_g1v2'
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\ELCOT\Downloads\Videos\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		set @end_time=getdate();
		print'>>>Load Duration: '+cast(datediff(second,@start_time,@end_time) as nvarchar)+'Seconds';
		print'>>> --------------';

		set @batch_end_time=getdate();
		print'=====================================================================================';
		print'Loading Bronze layer is Completed';
		print' - TotalLoad Duration: '+cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar)+'Seconds';
		print'=====================================================================================';
	end try
	begin catch
		print'======================================================================================';
		print'Error Occured During Loading Bronze Layer';
		print'Error Message'+error_message();
		print'Error Message'+cast(error_number() as nvarchar);
		print'Error Message'+cast(error_state()as nvarchar);
		print'======================================================================================';
	end catch
end
