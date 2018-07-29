

add a `thread_ts` field to the recognitions table (nullable)
for all recognition messages, check if the message is in a thread, and store the thread_ts accordingly

for recognition responses, post back to the thread using the `thread_ts` of the recognition

# docs
https://api.slack.com/docs/message-threading