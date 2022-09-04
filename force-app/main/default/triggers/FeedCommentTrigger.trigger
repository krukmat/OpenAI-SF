trigger FeedCommentTrigger on FeedComment (after insert, after update) {
    if (System.isFuture() == False){
        for (FeedComment item: Trigger.New){
            OpenAI.moderationCommentCategory(item.Id);
        }    
    }
}