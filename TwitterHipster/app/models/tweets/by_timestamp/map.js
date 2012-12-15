function(doc, meta) {
  // if its a tweet document, sort by created timestamp (epoch)
  if (doc.doctype == "tweet" && meta.type == "json") {
    var dt = new Date(0);
    dt.setUTCSeconds(doc.created);
    da = dateToArray(dt);
    emit(da, doc.content);
  } 
}