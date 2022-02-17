-- JBV | Delete all data from each of the tables below WITHOUT DESTROYING their structure, though
--     | Possibly useful if the 'destroy_all' command of 'the seeds.rb' file are not well ordered and/or fail
delete from users;
delete from gossips;
delete from cities;
delete from tags;
delete from comments;
delete from private_messages;
delete from gossip_tags;
delete from likes;

-- JBV | End of script