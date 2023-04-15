// To parse this JSON data, do
//
//     final personModel = personModelFromJson(jsonString);

class PersonModel {
  PersonModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
  });

  bool adult;
  int gender;
  int id;
  List<KnownFor> knownFor;
  KnownForDepartment knownForDepartment;
  String name;
  double popularity;
  String profilePath;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownFor: List<KnownFor>.from(
            json["known_for"].map((x) => KnownFor.fromJson(x))),
        knownForDepartment:
            knownForDepartmentValues.map[json["known_for_department"]]!,
        name: json["name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for": List<dynamic>.from(knownFor.map((x) => x.toJson())),
        "known_for_department":
            knownForDepartmentValues.reverse[knownForDepartment],
        "name": name,
        "popularity": popularity,
        "profile_path": profilePath,
      };
}

class KnownFor {
  KnownFor({
    this.backdropPath,
    this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    this.name,
    this.originalName,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    this.adult,
    this.originalTitle,
    this.releaseDate,
    this.title,
    this.video,
  });

  String? backdropPath;
  DateTime? firstAirDate;
  List<int> genreIds;
  int id;
  MediaType mediaType;
  String? name;

  String? originalName;
  String overview;
  String posterPath;
  double voteAverage;
  int voteCount;
  bool? adult;
  String? originalTitle;
  DateTime? releaseDate;
  String? title;
  bool? video;

  factory KnownFor.fromJson(Map<String, dynamic>? json) => KnownFor(
        backdropPath: json?["backdrop_path"],
        firstAirDate: json?["first_air_date"] == null
            ? null
            : DateTime.parse(json?["first_air_date"]),
        genreIds: List<int>.from(json?["genre_ids"].map((x) => x)),
        id: json?["id"],
        mediaType: mediaTypeValues.map[json?["media_type"]]!,
        name: json?["name"],
        originalName: json?["original_name"],
        overview: json?["overview"],
        posterPath: json?["poster_path"],
        voteAverage: json?["vote_average"]?.toDouble(),
        voteCount: json?["vote_count"],
        adult: json?["adult"],
        originalTitle: json?["original_title"],
        releaseDate: json?["release_date"] == null
            ? null
            : DateTime.parse(json?["release_date"]),
        title: json?["title"],
        video: json?["video"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date":
            "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "media_type": mediaTypeValues.reverse[mediaType],
        "name": name,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "adult": adult,
        "original_title": originalTitle,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
      };
}

enum MediaType { TV, MOVIE }

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

enum OriginCountry { GB, US, TR }

final originCountryValues = EnumValues(
    {"GB": OriginCountry.GB, "TR": OriginCountry.TR, "US": OriginCountry.US});

enum OriginalLanguage { EN, IT, KO, TL, TR }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "it": OriginalLanguage.IT,
  "ko": OriginalLanguage.KO,
  "tl": OriginalLanguage.TL,
  "tr": OriginalLanguage.TR
});

enum KnownForDepartment { ACTING, DIRECTING, WRITING }

final knownForDepartmentValues = EnumValues({
  "Acting": KnownForDepartment.ACTING,
  "Directing": KnownForDepartment.DIRECTING,
  "Writing": KnownForDepartment.WRITING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
