import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../admin_module/model/admin_class.dart';
import '../admin_module/model/user_class.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'donors_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE donors(id INTEGER PRIMARY KEY, name TEXT, blood_group TEXT)',
        );
        await db.execute(
          'CREATE TABLE user_requests(id INTEGER PRIMARY KEY, donor_id INTEGER, name TEXT, blood_group TEXT, quantity INTEGER, FOREIGN KEY(donor_id) REFERENCES donors(id))',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'CREATE TABLE user_requests(id INTEGER PRIMARY KEY, donor_id INTEGER, name TEXT, blood_group TEXT, quantity INTEGER, FOREIGN KEY(donor_id) REFERENCES donors(id))',
          );
        }
      },
    );
  }

  // Donor related methods
  Future<int?> addDonor(Donor donor) async {
    final db = await database;
    try {
      int id = await db.insert(
        'donors',
        donor.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Donor added with id: $id');
      return id;
    } catch (e) {
      print('Error adding donor: $e');
      return null;
    }
  }

  Future<List<Donor>> getDonors() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> donorsMapList = await db.query('donors');
      return donorsMapList.map((donorMap) => Donor.fromJson(donorMap)).toList();
    } catch (e) {
      print('Error fetching donors: $e');
      return [];
    }
  }

  Future<void> updateDonor(Donor donor) async {
    final db = await database;
    try {
      await db.update(
        'donors',
        donor.toJson(),
        where: 'id = ?',
        whereArgs: [donor.id],
      );
      print('Donor updated: ${donor.id}');
    } catch (e) {
      print('Error updating donor: $e');
    }
  }

  Future<void> deleteDonor(int id) async {
    final db = await database;
    try {
      await db.delete(
        'donors',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('Donor deleted: $id');
    } catch (e) {
      print('Error deleting donor: $e');
    }
  }

  // User request related methods
  Future<int?> addUserRequest(UserRequest request) async {
    final db = await database;
    try {
      int id = await db.insert(
        'user_requests',
        request.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      print('User request added with id: $id');
      return id;
    } catch (e) {
      print('Error adding user request: $e');
      return null;
    }
  }

  Future<List<UserRequest>> getUserRequests() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> requestsMapList = await db.query('user_requests');
      return requestsMapList.map((requestMap) => UserRequest.fromJson(requestMap)).toList();
    } catch (e) {
      print('Error fetching user requests: $e');
      return [];
    }
  }

  Future<void> updateUserRequest(UserRequest request) async {
    final db = await database;
    try {
      await db.update(
        'user_requests',
        request.toJson(),
        where: 'id = ?',
        whereArgs: [request.id],
      );
      print('User request updated: ${request.id}');
    } catch (e) {
      print('Error updating user request: $e');
    }
  }

  Future<void> deleteUserRequest(int id) async {
    final db = await database;
    try {
      await db.delete(
        'user_requests',
        where: 'id = ?',
        whereArgs: [id],
      );
      print('User request deleted: $id');
    } catch (e) {
      print('Error deleting user request: $e');
    }
  }
}
