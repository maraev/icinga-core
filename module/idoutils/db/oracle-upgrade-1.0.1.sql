-- --------------------------------------------------------
-- oracle-upgrade-1.0.1.sql
-- DB definition for Oracle
-- 
-- set command_line to varchar2(1024)
-- sets index on several tables for improved delete
-- removes triggers and adds squences instead
--
-- requires ocilib, oracle (instantclient) libs+sdk  to work
-- specify oracle (instantclient) libs+sdk in ocilib configure
-- ./configure \
--      --with-oracle-headers-path=/opt/oracle/product/instantclient/instantclient_11_1/sdk/include \
--      --with-oracle-lib-path=/opt/oracle/product/instantclient/instantclient_11_1/
--
-- enable ocilib in Icinga with
-- ./configure --enable-idoutils --enable--oracle
-- 
-- copy to $ORACLE_HOME 
-- # sqlplus username/password
-- SQL> @oracle-upgrade-1.0.1.sql
--
-- current version: 2010-02-03 Michael Friedrich <michael.friedrich(at)univie.ac.at>
--
-- -- --------------------------------------------------------

--
-- command_line
--

ALTER TABLE hostchecks MODIFY COLUMN command_line varchar2(1024);
ALTER TABLE servicechecks MODIFY COLUMN command_line varchar2(1024);
ALTER TABLE systemcommands MODIFY COLUMN command_line varchar2(1024);
ALTER TABLE eventhandlers MODIFY COLUMN command_line varchar2(1024);


--
-- index
--

-- for periodic delete 
-- instance_id and
-- TIMEDEVENTS => scheduled_time
-- SYSTEMCOMMANDS, SERVICECHECKS, HOSTCHECKS, EVENTHANDLERS  => start_time
-- EXTERNALCOMMANDS => entry_time

-- instance_id
CREATE INDEX instance_id_idx on timedevents(instance_id);
CREATE INDEX instance_id_idx on systemcommands(instance_id);
CREATE INDEX instance_id_idx on servicechecks(instance_id);
CREATE INDEX instance_id_idx on hostchecks(instance_id);
CREATE INDEX instance_id_idx on eventhandlers(instance_id);
CREATE INDEX instance_id_idx on externalcommands(instance_id);

-- time
CREATE INDEX time_id_idx on timedevents(scheduled_time);
CREATE INDEX time_id_idx on systemcommands(start_time);
CREATE INDEX time_id_idx on servicechecks(start_time);
CREATE INDEX time_id_idx on hostchecks(start_time);
CREATE INDEX time_id_idx on eventhandlers(start_time);
CREATE INDEX time_id_idx on externalcommands(entry_time);


-- for starting cleanup - referenced in dbhandler.c:882
-- instance_id only

-- realtime data
CREATE INDEX instance_id_idx on programstatus(instance_id);
CREATE INDEX instance_id_idx on hoststatus(instance_id);
CREATE INDEX instance_id_idx on servicestatus(instance_id);
CREATE INDEX instance_id_idx on contactstatus(instance_id);
CREATE INDEX instance_id_idx on timedeventqueue(instance_id);
CREATE INDEX instance_id_idx on comments(instance_id);
CREATE INDEX instance_id_idx on scheduleddowntime(instance_id);
CREATE INDEX instance_id_idx on runtimevariables(instance_id);
CREATE INDEX instance_id_idx on customvariablestatus(instance_id);

-- config data
CREATE INDEX instance_id_idx on configfiles(instance_id);
CREATE INDEX instance_id_idx on configfilevariables(instance_id);
CREATE INDEX instance_id_idx on customvariables(instance_id);
CREATE INDEX instance_id_idx on commands(instance_id);
CREATE INDEX instance_id_idx on timeperiods(instance_id);
CREATE INDEX instance_id_idx on timeperiod_timeranges(instance_id);
CREATE INDEX instance_id_idx on contactgroups(instance_id);
CREATE INDEX instance_id_idx on contactgroup_members(instance_id);
CREATE INDEX instance_id_idx on hostgroups(instance_id);
CREATE INDEX instance_id_idx on hostgroup_members(instance_id);
CREATE INDEX instance_id_idx on servicegroups(instance_id);
CREATE INDEX instance_id_idx on servicegroup_members(instance_id);
CREATE INDEX instance_id_idx on hostescalations(instance_id);
CREATE INDEX instance_id_idx on hostescalation_contacts(instance_id);
CREATE INDEX instance_id_idx on serviceescalations(instance_id);
CREATE INDEX instance_id_idx on serviceescalation_contacts(instance_id);
CREATE INDEX instance_id_idx on hostdependencies(instance_id);
CREATE INDEX instance_id_idx on contacts(instance_id);
CREATE INDEX instance_id_idx on contact_addresses(instance_id);
CREATE INDEX instance_id_idx on contact_notificationcommands(instance_id);
CREATE INDEX instance_id_idx on hosts(instance_id);
CREATE INDEX instance_id_idx on host_parenthosts(instance_id);
CREATE INDEX instance_id_idx on host_contacts(instance_id);
CREATE INDEX instance_id_idx on services(instance_id);
CREATE INDEX instance_id_idx on service_contacts(instance_id);
CREATE INDEX instance_id_idx on service_contactgroups(instance_id);
CREATE INDEX instance_id_idx on host_contactgroups(instance_id);
CREATE INDEX instance_id_idx on hostescalation_contactgroups(instance_id);
CREATE INDEX instance_id_idx on serviceescalationcontactgroups(instance_id);


--
-- triggers/sequences
--


