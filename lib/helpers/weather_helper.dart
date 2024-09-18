import 'dart:convert';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:getx_weather_app/modals/favourite_modal.dart';
import 'package:getx_weather_app/modals/weather_modal.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

enum FavouriteTable { id, city, isFavorite }

class WeatherHelper {
  WeatherHelper._();
  static final WeatherHelper wHelper = WeatherHelper._();

  Future<Weather?> getWeatherData({String cityName = 'Surat'}) async {
    Weather? weather;

    String weatherApi =
        "http://api.weatherapi.com/v1/current.json?key=65578899c53c48b999f121435240206&q=$cityName";

    http.Response response = await http.get(
      Uri.parse(weatherApi),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      weather = Weather.fromJson(json: data);
      return weather;
    }

    log(response.statusCode as String);
    return null;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  late Database database;

  String dbName = "weather.db";
  String tableName = "weather";
  String sql = "";

  Future<void> init() async {
    String path = await getDatabasesPath();

    database = await openDatabase(
      '$path/$tableName',
      version: 1,
      onUpgrade: (db, v, v1) {
        String query =
            """create table if not exists $tableName(${FavouriteTable.id.name} integer primary key autoincrement,
            ${FavouriteTable.city.name} text unique,
            ${FavouriteTable.isFavorite.name} boolean not null)""";

        db
            .execute(query)
            .then(
              (value) => Logger().i('table created'),
            )
            .onError(
              (error, stackTrace) => Logger().e('error : $error}'),
            );
      },
    );
  }

  Future<void> insertData({required Favourite favorite}) async {
    sql =
        "insert into $tableName(${FavouriteTable.city.name},${FavouriteTable.isFavorite.name}) values(?,?)";
    List args = [
      favorite.city,
      favorite.isFavorite,
    ];
    await database
        .rawInsert(sql, args)
        .then(
          (value) => Logger().i('inserted'),
        )
        .onError(
          (error, stackTrace) => Logger().e('Error : $error'),
        );
    ;
  }

  Future<void> deleteData({required String city}) async {
    await database
        .delete(
          tableName,
          where: "city=?",
          whereArgs: [city],
        )
        .then(
          (value) => Logger().i('Deleted'),
        )
        .onError(
          (error, stackTrace) => Logger().e('Error : $error'),
        );
  }

  Future<List<Favourite>> getAllData() async {
    List<Favourite> allFavorite = [];

    sql = "select * from $tableName;";
    List Data = await database.rawQuery(sql);
    allFavorite = Data.map((e) => Favourite.formMap(data: e)).toList();

    return allFavorite;
  }
}
