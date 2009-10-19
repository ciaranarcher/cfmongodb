<cfcomponent output="false">

<cfscript>
//This is configurable.
server_name = 'localhost';
server_port = 27017;
db_name = 'default_db';
collection_name = 'default_collection';	
	
//maybe this goes in super class?	
mongo = createObject('java', 'com.mongodb.Mongo').init( variables.server_name , variables.server_port );
db = mongo.getDb(db_name);
collection = db.getCollection(collection_name);


//------------------------------------------------------------------------//
function add(key,value,o){
  //add key value pair to object ... todo
}


function put(o){ 
 var doc =  createObject('java', 'com.mongodb.BasicDBObject').init();
 var id = chr(0);
  doc.putAll(o);
  id = collection.insert(doc).get("_id");
  o._id = id; //add the _id object to the struct
  return id;
}//end function



function get(field,value){
  var q = createObject('java', 'com.mongodb.BasicDBObject').init(field,value);
  var cursor = collection.find(q);
  return cursor.next();
} //end function



function count(){
  return collection.getCount();
}


function findOne(){
  return collection.findOne();
} //


function find(){
   var sort_spec =  createObject('java', 'com.mongodb.BasicDBObject').init({pub_date :-1});;	
   return collection.find().sort( sort_spec ).toArray(); 
} //end function


function delete(o){
  var  obj = get("_id", o._id);
  return collection.remove(obj); //id's of deleted items
} //end function


//Note the ObjectId object. This creates an ObjectId from
//the string representation of 

function deleteById(id){
  var objId = createObject('java','com.mongodb.ObjectId').init(id);
  var  obj = get("_id", objId);
  return collection.remove(obj); //id's of deleted items
} //en


function update(o){
  var obj = get("_id", o._id);
  var new_object = createObject('java', 'com.mongodb.BasicDBObject').init(o);
  return collection.update(obj, new_object, false, false);
    
} //end function



//not tested ...
function switchCollection(collection_name){
  collection = db.getCollection(collection_name);
}

</cfscript>

</cfcomponent>