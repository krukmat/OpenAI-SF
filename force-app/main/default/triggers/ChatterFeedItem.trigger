trigger ChatterFeedItem on FeedItem (after insert, after update) {
    if (System.isFuture() == False){
        for (FeedItem item: Trigger.New){
            OpenAI.moderationCategory(item.Id);
        }    
    }
}