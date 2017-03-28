--Decay Query Based on timestamp already in the game
--This has been tested in prod on A15 Server (https://topconanservers.com/server/172.96.164.194:24023)
--Updated to run faster without as many date translation
--Changed the update statement so that if you run this often, if the in game timestamp were ever to break, your characters wouldn't get deleted until they fixed it
--V 2.1 should include thralls per Chewy's help
update characters set lastTimeOnline = strftime('%s', 'now') where lastTimeOnline is NULL; --In case timestamp ever breaks, this keeps your characters refreshed now that this field is always populated
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild is null);
delete from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from item_properties where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from item_properties where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from item_inventory where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from item_inventory where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from actor_position where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from actor_position where id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null);
delete from character_stats where char_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild is null);
delete from character_stats where char_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from characters where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild is null);
delete from characters where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
