

create or alter procedure bronze.load_bronze_layer AS
begin

declare @start_time datetime,@end_time datetime,@start_all_batch_time datetime,@end_all_batch_time datetime
set @start_all_batch_time = GETDATE()
begin try
print '***********************************'
print 'Load Bronze Layer'
print '***********************************'



print '--------------------------'
print 'Load From CRM Source'
print '--------------------------'

print '>>>Start load table bronze.crm_cust_info'
set @start_time = GETDATE()
TRUNCATE TABLE bronze.crm_cust_info
BULK INSERT bronze.crm_cust_info
from 'F:\COURSE DATA ANALYSIS\Projects\SQL project\source_crm\cust_info.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
)
set @end_time = GETDATE()
print 'Loading table time: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
print '>>>End load table bronze.crm_cust_info'

print '>>>Start loading table bronze.crm_prd_info'
set @start_time = getdate()
Truncate table bronze.crm_prd_info
BULK INSERT bronze.crm_prd_info
from 'F:\COURSE DATA ANALYSIS\Projects\SQL project\source_crm\prd_info.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
)
set @end_time = getdate()

print 'Loading table time: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
print '>>>end loading table bronze.crm_prd_info'

print '>>>Start loading table bronze.crm_sales_details'
set @start_time = GETDATE()
TRUNCATE TABLE bronze.crm_sales_details
BULK INSERT bronze.crm_sales_details
from 'F:\COURSE DATA ANALYSIS\Projects\SQL project\source_crm\sales_details.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
)
set @end_time = GETDATE()

print 'Loading table time: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
print '>>>End loading table bronze.crm_sales_details'

print '--------------------------'
print 'Load From ERP Source'
print '--------------------------'


print '>>>Start loading table bronze.erp_cust_az12'
set @start_time = GETDATE()
TRUNCATE TABLE bronze.erp_cust_az12
Bulk insert bronze.erp_cust_az12
from 'F:\COURSE DATA ANALYSIS\Projects\SQL project\source_erp\CUST_AZ12.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
)
set @end_time = getdate()
print 'Loading table time: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
print '>>>End loading table bronze.erp_cust_az12'


print '>>>Start loading table bronze.erp_loc_a101'
set @start_time = GETDATE()
Truncate table bronze.erp_loc_a101
BULK INSERT bronze.erp_loc_a101
from 'F:\COURSE DATA ANALYSIS\Projects\SQL project\source_erp\LOC_A101.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
)
set @end_time = getdate()
print 'Loading table time: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
print '>>>End loading table bronze.erp_loc_a101'

print '>>>Start loading table bronze.erp_px_cat_g1v2'
set @start_time = GETDATE()
TRUNCATE TABLE bronze.erp_px_cat_g1v2
BULK INSERT bronze.erp_px_cat_g1v2
from 'F:\COURSE DATA ANALYSIS\Projects\SQL project\source_erp\PX_CAT_G1V2.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
)
set @end_time = getdate()
print 'Loading table time: ' + cast(datediff(second,@start_time,@end_time) as nvarchar) + ' seconds'
print '>>>End loading table bronze.erp_px_cat_g1v2'

set @end_all_batch_time = GETDATE()
print 'Time of loading all bronze layer is : ' + cast(datediff(second,@start_all_batch_time,@end_all_batch_time) as nvarchar) + ' seconds'
end try
begin catch
print 'There An Error In The Load Layer'
print 'Error Message' + Error_Message()
print 'Error Number' + cast( Error_NUmber() as nvarchar)
end catch
END