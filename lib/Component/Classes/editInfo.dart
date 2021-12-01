import 'package:movie_tracker/constant.dart';

class EditInfo {
  String uid;
  String id;
  String name;
  List<dynamic> genre;
  int totalEpi;
  int watchedEpi;
  Type type;
  List<dynamic> runtime;
  Status status;
  DateTime airingDt;
  watchStatus wStatus;
  EditInfo({
    this.uid,
    this.genre,
    this.name,
    this.id,
    this.runtime,
    this.airingDt,
    this.type = Type.Series,
    this.status = Status.Ongoing,
    this.totalEpi = 0,
    this.watchedEpi = 0,
    this.wStatus = watchStatus.InProgress,
  });
  void toggleWatchStatus() {
    if (this.wStatus == watchStatus.InProgress) {
      this.wStatus = watchStatus.Completed;
    } else {
      this.wStatus = watchStatus.InProgress;
    }
  }

  void toggleType() {
    if (this.type == Type.Series) {
      this.type = Type.Movie;
    } else {
      this.type = Type.Series;
    }
  }

  void toggleStatus() {
    if (this.status == Status.Ongoing) {
      this.status = Status.Completed;
    } else {
      this.status = Status.Ongoing;
    }
  }
}

/*
Series Table: uid, name, type, status, total_epi, epi_watched, runtime[]
Movies Table: uid, name, type
*/
