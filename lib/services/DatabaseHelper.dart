import 'package:path/path.dart' ;
import 'package:sqflite/sqflite.dart' ;

class Goal {
  int id;
  String goalText;
  Goal({ this .id,this .goalText});
  Map<String, dynamic> toMap() {
    return { 'id':id,'goalText': goalText};
  }
}
  class DatabaseHelper {
   static final _databaseName = "myDB.db" ;
   static final _databaseVersion = 1 ;
   static final table = 'goal' ;
   static final columnId = 'id' ;
   static final columnTitle = 'goalText' ;
   DatabaseHelper.init();
   static final DatabaseHelper instance = DatabaseHelper.init();
   static Database _database;
   Future<Database> get database async {
   if (_database != null ) return _database;
   _database = await _initDatabase();
   return _database;
   }
   _initDatabase() async {
   String path = join(await getDatabasesPath(), _databaseName);
   return await openDatabase(path,
   version: _databaseVersion, onCreate: _onCreate);
   }
   Future _onCreate(Database db, int version) async {
     await db.execute('' 'CREATE TABLE $table ($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnTitle TEXT NOT NULL)'' ');
}
   Future<int> insert(Goal goal) async {
      Database db = await instance.database;
      var res = await db.insert(table,goal.toMap());
      String str=goal.goalText;
      print("add $str");
      return res;
   }
      Future<List<Map<String, dynamic>>> queryAllRows() async {
      Database db = await instance.database;
      var res = await db.query(table);
      return res;
   }

  }