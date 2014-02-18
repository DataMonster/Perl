I created three script programs to help capture tweets and follower list and further analyze tweets and user relations.
“buildTweets.pl”
“buildTweets” program input start user id, how many round you need to capture tweets. The search topic is “Paul Walker” for now. The reason will this program need to sleep for a while during execution is because TWITTER.COM will not allow query too quick or too much at one time, probably server protection (TWITTER.COM only allow around 170 queries per 15 minutes). The program will create go over all possible ids and save all original tweets from valid and open user (you will not get tweets from a invalid user id or a protected user id) into a .txt file with user id as filename in folder “contents”. At the same time, the program will save NPL modified tweets into folder “modicontents” with the same name. Then, the program will modify the search topic with the same NPL process and create a data.txt to store the user id and topic mentioned time (for example: 412700000 2, means user with id 412700000 has mentioned twice the topic). The program algorithm details as follows:
1) Obtain tweets
Use Twitter API to get first 200 tweets for each user, in the sub getT(). And write the tweets into /contents/USERID.txt.
2) NLP a tweet
The NLP process for the sentence: for each word, use dictionary (convert twitter
abbreviation to common language, “notes.txt”), then get all the numbers in the same formate, then use namecase (make the first character capitalized), then stem the word (convert English tenses into regular words and get rid of all special symbols). For each tweet this process will be applied on and save the modi_tweet into modi_contents/USERID.txt. Also do this process for topic.
3) Output
Each valid and open user in the capture range will have two .txt files.
“buildFollower.pl”
“buildFollower.pl” will get ids from data.txt (the one of the output from buildTweets.pl ), and output each user id with their follower on the same line in follower.txt.
“getRelation.pl”
“getRelation.pl” will go through the follower.txt and find out the follower relation of all the user who has tweeted the topic. The output is relation.txt.

1.buildTweets.pl:	run with argument, example: perl buildTweets.pl 42700000 1
(it is common to get error handle information in the terminal, on purpose)
2.buildFollower.pl:	run directly
3.getRelation.pl:	run directly
4.data.txt:	example of results
5.notes.txt:	dictionary for twitter
6.relation.txt:		example of results
7.followers.txt:	example of results
