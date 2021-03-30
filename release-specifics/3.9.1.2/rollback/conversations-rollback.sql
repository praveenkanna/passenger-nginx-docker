'
-- Release rollback driver
spool rollback-cedf-conversions.log

-- ROLLBACK STEPS HERE

commit;

spool off
