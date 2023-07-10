class Messsage {
  final String message;
  final String id;

  Messsage(this.message,this.id);
  factory Messsage.fromjson( jsonData) {
    return Messsage(jsonData["messages"],jsonData["id"]);
    
  }
    @override
  String toString() {
    // TODO: implement toString
    return " $message";
  }
 }