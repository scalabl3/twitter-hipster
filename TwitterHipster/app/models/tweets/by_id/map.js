function(doc, meta) {
  // list tweets by id
  if (doc.doctype == "tweet" && meta.type == "json") {
    emit(doc.tweet_id, doc.content);
  }
}
