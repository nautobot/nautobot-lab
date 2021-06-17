#!/bin/bash

export PGUSER="postgres"
export PGDATABASE=$DB_NAME

psql -c "DROP SCHEMA public CASCADE";
psql -c "CREATE SCHEMA public";
psql -c "GRANT ALL ON SCHEMA public TO postgres";
psql -c "GRANT ALL ON SCHEMA public TO public";
psql -c "GRANT ALL ON SCHEMA public TO ${DB_USER}";

export PGUSER=$DB_USER
export PGPASSWORD=$DB_PASSWORD

psql < {{ nautobot_root }}/templates/nautobot_backup.dump

{{ nautobot_root }}/bin/nautobot-server migrate
{{ nautobot_root }}/bin/nautobot-server invalidate all
