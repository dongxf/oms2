# this file copy sql result to fc4 operation directory
cp 2-import-pospal-goods.sql ~/fc4/misc/db
cp 3-import-pospal-users.sql ~/fc4/misc/db
cp 4-import-pospal-comments.sql ~/fc4/misc/db
cat ~/fc4/misc/db/1-init-crmeb.sql ~/fc4/misc/db/2-import-pospal-goods.sql ~/fc4/misc/db/3-import-pospal-users.sql ~/fc4/misc/db/4-import-pospal-comments.sql > ~/fc4/misc/db/launch-crmeb.sql
echo "launch-crmeb.sql is ready in ~/fc4/misc/db."
