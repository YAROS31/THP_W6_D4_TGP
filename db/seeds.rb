# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# Chronometer starts !
puts "*** Started at #{Time.now} ***"
puts

# DESTROY SECTION - Uncomment to truncate all SQLite tables + anihilate all created objects + empty tmp tables
puts "[DESTROY SECTION - BEGIN]"
puts "  > Destroying objects and deleting from tables"
City.destroy_all
puts "    - Cities flushed"
User.destroy_all
puts "    - Users flushed"
Gossip.destroy_all
puts "    - Gossips flushed"
Tag.destroy_all
puts "    - Tags flushed"
GossipTag.destroy_all
puts "    - Links between gossips and tags flushed"
Like.destroy_all
puts "    - Likes flushed"
Comment.destroy_all
puts "    - Comments flushed"
PrivateMessage.destroy_all
puts "    - PrivateMessages flushed"
puts "  > All objects destroyed successfully"
puts "[DESTROY SECTION - END]"
puts

# POPULATE SECTION - Notice: order of population may be structuring (cannot load data into 'appointments' before 'doctors' and 'patients' exist ;-)
puts "[POPULATE SECTION - BEGIN]"

##########################
# 01 - Populate 'cities' #
##########################
puts "  > Populating 'cities'"
50.times do
	City.create(city_name: Faker::Address.city, 
              zip_code: Faker::Address.zip)
end
puts "    - Done populating 'cities'"

#########################
# 02 - Populate 'users' #
50.times do
	User.create(first_name: Faker::Name.first_name.capitalize, 
              last_name: Faker::Name.last_name.upcase,
              nickname: Faker::Superhero.name,
              gender: Faker::Demographic.sex,
              birthdate: Faker::Date.between(from: '1978-03-27', to: '2014-07-03'),
              city_id: City.all.sample.id,
              email: Faker::Internet.safe_email,
              password: "TGP_2022")
end
puts "    - Done populating 'users' (main fields)"

User.all.each do |my_user|
  my_user.age = (Date.today.year - my_user.birthdate.year)
  my_user.is_adult = (my_user.age >= 18)
  my_user.save
end
puts "    - Done populating 'users' age and 'is_adult' boolean switch (computed)"

#####################################
# 03 - Populates 'private_messages' #
#####################################
puts "  > Populating 'private messages'"
10.times do
  PrivateMessage.create(object: Faker::DcComics.title,
                        body: Faker::Lorem.paragraph_by_chars(number: 200, supplemental: false),
                        read: Faker::Boolean.boolean,
                        sender_id: 0,
                        recipient_id: 0,
                        previous_message_id: 0)
end
puts "    - Done populating 'private messages' (main fields)"

# Message nr. 1 is linked to no other message (first of the discussion)
# NOTICE: uses first method to UPDATE applied to a 'PrivateMessage' object
PrivateMessage.update(PrivateMessage.all[0].id,
                      sender_id: User.all.first.id, 
                      recipient_id: User.all.last.id, 
                      previous_message_id: 0)                     

# Message nr. 2 is the answer of last user to 1st user
# NOTICE: uses second method to UPDATE applied to the 'PrivateMessage' class + an object 'id'
PrivateMessage.update(PrivateMessage.all[1].id,
                      sender_id: User.all.last.id, 
                      recipient_id: User.all.first.id, 
                      previous_message_id: PrivateMessage.all[0].id)

# Message nr. 3 is the answer of 1st user to last user
# NOTICE: uses update method nr. 1
PrivateMessage.update(PrivateMessage.all[2].id,
                      sender_id: User.all.first.id, 
                      recipient_id: User.all.last.id, 
                      previous_message_id: PrivateMessage.all[1].id)

# Message nr. 4 is the beginning of a new message flow between 2nd user and last user
# NOTICE: uses update method nr. 1
PrivateMessage.update(PrivateMessage.all[3].id,
                      sender_id: User.all[1].id, 
                      recipient_id: User.all.last.id, 
                      previous_message_id: 0)

# Message nr. 5 is the answer of last user to 2nd user
# NOTICE: uses update method nr. 2
PrivateMessage.update(PrivateMessage.all[4].id, 
                      sender_id: User.all.last.id, 
                      recipient_id: User.all[1].id, 
                      previous_message_id: PrivateMessage.all[3].id)

# Message nrs. 6 to 9 instantiate a new discussion between 2nd and 3rd users (2nd having the first and last words ;-)
# NOTICE: uses update method nr. 1
PrivateMessage.update(PrivateMessage.all[5].id, 
                      sender_id: User.all[1].id, 
                      recipient_id: User.all[2].id, 
                      previous_message_id: 0)
PrivateMessage.update(PrivateMessage.all[6].id, 
                      sender_id: User.all[2].id, 
                      recipient_id: User.all[1].id, 
                      previous_message_id: PrivateMessage.all[5].id)
PrivateMessage.update(PrivateMessage.all[7].id, 
                      sender_id: User.all[1].id, 
                      recipient_id: User.all[2].id, 
                      previous_message_id: PrivateMessage.all[6].id)
PrivateMessage.update(PrivateMessage.all[8].id, 
                      sender_id: User.all[2].id, 
                      recipient_id: User.all[1].id, 
                      previous_message_id: PrivateMessage.all[7].id)
PrivateMessage.update(PrivateMessage.all[9].id, 
                      sender_id: User.all[1].id, 
                      recipient_id: User.all[2].id, 
                      previous_message_id: PrivateMessage.all[8].id)

puts "    - Done populating 'private messages' with 'sender', 'recipient' and 'previous_message', creating the discussion flow logic"

###########################
# 04 - Populate 'gossips' #
###########################
puts "  > Populating 'gossips'"
tmp_phrase_start = ["While walking in the corridor, I heard",
                    "While pissing, I heard voices saying",
                    "My girl and I were in bed when she told me",
                    "My best friend shared with me about",
                    "I shouldn't tell you but",
                    "What do you think if I tell you that",
                    "Just after climax, my toy boy revealed to me that",
                    "I know it may sound in-cre-di-ble but I swear to God",
                    "If it wasn't written, big caps, in today's newspapers, I wouldn't believe that",
                    "Chuck Norris disclosed to me"]
tmp_frequence = ["sometimes",
                 "regularly",
                 "daily",
                 "once in a while",
                 "whenever possible"]
50.times do
  Gossip.create(title: "About #{User.all.sample.first_name} #{Faker::Verb.ing_form} #{User.all.sample.first_name}", 
                content: "#{tmp_phrase_start.sample} #{User.all.sample.first_name} is #{tmp_frequence.sample} #{Faker::Verb.ing_form} #{User.all.sample.first_name} #{Faker::Lorem.paragraph_by_chars(number: 50, supplemental: false)}.",
                user_id: User.all.sample.id)
end
puts "    - Done populating 'gossips' content and link with 'users'"

########################
# 05 - Populate 'tags' #
########################
puts "  > Populating 'tags'"
Tag.create(label: "#starsystem")
Tag.create(label: "#thpsailor")
Tag.create(label: "#thpstaff")
Tag.create(label: "#frenchtech")
Tag.create(label: "#adultcontent")
Tag.create(label: "#unicornsvanillaicecreamsandmarshmallows")
Tag.create(label: "#professional")
Tag.create(label: "#personal")
Tag.create(label: "#fun")
Tag.create(label: "#topsecret")
puts "    - Done populating 'tags'"

###############################
# 06 - Populate 'gossip_tags' #
###############################
puts "  > Populating joint table between 'tags' and 'gossips'"
Gossip.all.each do |my_gossip|
  rand(0..3).times do 
    GossipTag.create(gossip_id: my_gossip.id, 
                     tag_id: Tag.all.sample.id)
  end
end
puts "    - Done randomly adding 0 to 3 'tag(s)' to each and every 'gossip'"

############################
# 07 - Populate 'comments' #
############################
puts "  > Populating 'comments'"
tmp_reactions = ["I couldn't agree more!",
                "How can you think and say that! Dumb broad!",
                "And here is a stupid content authored by you... Again",
                "This is so inspiring. You made my day!",
                "Could I have your number?",
                "As an expert in this field, I can juste tell you're writing sh*t, a**h**e!",
                "Hey @JohnDoe, have a look at this!",]
Gossip.all.each do |my_gossip|
  rand(0..5).times do
    Comment.create(content: tmp_reactions.sample,
                   user_id: User.all.sample.id,
                   gossip_id: my_gossip.id,
                   comment_id: 0)
  end
end
puts "    - Done randomly adding 0..5 random 'comments' to existing 'gossips'"

tmp_comments_table = Comment.all  # Just making sure we do not add to an ever growing table of comments >> infinite loop
tmp_comments_table.all.each do |my_existing_comment|
  rand(0..3).times do  
    Comment.create(content: tmp_reactions.sample,
                   user_id: User.all.sample.id,
                   gossip_id: 0,
                   comment_id: my_existing_comment.id)
  end
end
puts "    - Done randomly adding 0..3 random 'comments' to existing 'comments'"

#########################
# 08 - Populate 'likes' #
#########################
puts "  > Populating 'likes'"
tmp_like_types = ["like", "love", "support", "insightful", "curious"]
Gossip.all.each do |my_liked_gossip|
  if rand(1..2)%2 == 0  
    Like.create(like_type: tmp_like_types.sample,
                user_id: User.all.sample.id,
                gossip_id: my_liked_gossip.id,
                comment_id: 0)
  end
end
puts "    - Done randomly adding random 'likes' to existing 'gossips'"

Comment.all.each do |my_liked_comment|
  if rand(1..2)%2 == 0
    Like.create(like_type: tmp_like_types.sample,
                user_id: User.all.sample.id,
                gossip_id: 0,
                comment_id: my_liked_comment.id)
  end
end
puts "    - Done randomly adding random 'likes' to existing 'comments'"

puts "[POPULATE SECTION - END]"
puts

# Chronometer stops !
puts "*** Ended at #{Time.now} ***"