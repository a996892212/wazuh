/*
 * SQL Schema for upgrading databases
 * Copyright (C) 2015, Wazuh Inc.
 *
 * Jun 27, 2022
 *
 * This program is a free software, you can redistribute it
 * and/or modify it under the terms of GPLv2.
*/

CREATE TABLE IF NOT EXISTS _sys_hotfixes (
    scan_id INTEGER,
    scan_time TEXT,
    hotfix TEXT,
    checksum TEXT NOT NULL CHECK (checksum <> ''),
    PRIMARY KEY (scan_id, hotfix)
);

INSERT INTO _sys_hotfixes SELECT scan_id, scan_time, hotfix, CASE WHEN checksum <> '' THEN checksum ELSE 'legacy' END AS checksum FROM sys_hotfixes;
DROP TABLE IF EXISTS sys_hotfixes;
ALTER TABLE _sys_hotfixes RENAME to sys_hotfixes;

INSERT OR REPLACE INTO metadata (key, value) VALUES ('db_version', 9);
