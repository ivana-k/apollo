-- Create keyspace
CREATE KEYSPACE IF NOT EXISTS apollo
WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

-- Use keyspace
--USE apollo;

-- Create table
CREATE TABLE IF NOT EXISTS apollo.org (
    id UUID PRIMARY KEY,
    name TEXT
);
CREATE INDEX IF NOT EXISTS ON apollo.org (name);

CREATE TABLE IF NOT EXISTS apollo.permission (
    id UUID PRIMARY KEY,
    name TEXT
);

CREATE TABLE IF NOT EXISTS apollo.user (
    id UUID,
    name TEXT,
    surname TEXT,
    email TEXT,
    username TEXT,
    created_at DATE,
    updated_at DATE,
    PRIMARY KEY (id, username)
);
CREATE INDEX IF NOT EXISTS ON apollo.user(email);
CREATE INDEX IF NOT EXISTS ON apollo.user(username);


CREATE TABLE IF NOT EXISTS apollo.org_user (
    org_id UUID,
    user_id UUID,
    permissions SET<TEXT>,
    is_owner BOOLEAN,
    PRIMARY KEY (org_id, user_id)
);

INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'config.get') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'config.put') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'org.namespace.add') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'org.namespace.get') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'namespace.delete') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'namespace.putconfig') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'namespace.put') IF NOT EXISTS; -- za bilo kakve izmene ns i dodelu resursa
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'namespace.app.add') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'app.delete') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'app.put') IF NOT EXISTS; -- dodela resursa app
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'node.get') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'node.put') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'node.label.put') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'node.label.get') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'node.label.delete') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'org.add') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'config.send') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'config.app.send') IF NOT EXISTS;
INSERT INTO apollo.permission (id, name) VALUES (uuid(), 'scmp.sys.admin') IF NOT EXISTS;