class Favourite {
  String city;
  int isFavorite;

  Favourite(this.city, this.isFavorite);

  factory Favourite.formMap({required Map data}) => Favourite(
        data['city'],
        data['isFavorite'],
      );

  Map<String, dynamic> get getFavorite => {
        "city": city,
        "isFavorite": isFavorite,
      };
}
