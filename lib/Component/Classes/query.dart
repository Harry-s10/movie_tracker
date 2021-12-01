import '../../constant.dart';

class QueryStmt {
  List<dynamic> genre;
  List<dynamic> runtime;
  List<dynamic> airingYear;
  Status status;
  watchStatus wStatus;
  QueryStmt(
      {this.genre,
      this.airingYear,
      this.runtime,
      this.status = Status.None,
      this.wStatus = watchStatus.InProgress});

  void toggleStatus() {
    if (this.wStatus == watchStatus.InProgress) {
      if (this.status == Status.Ongoing) {
        this.status = Status.Completed;
      } else {
        this.status = Status.Ongoing;
      }
    }
  }

  void toggleWatchStatus() {
    if (this.wStatus == watchStatus.InProgress) {
      this.wStatus = watchStatus.Completed;
      this.status = Status.Completed;
    } else {
      this.wStatus = watchStatus.InProgress;
    }
  }

  void reset() {
    this.genre = [];
    this.airingYear = [];
    this.status = Status.None;
    this.wStatus = watchStatus.None;
    this.runtime = [];
  }

  String getStatus() {
    switch (this.status) {
      case Status.Completed:
        return "Completed";
      case Status.Ongoing:
        return "Ongoing";
      default:
        return "None";
    }
  }

  String getWatchStatus() {
    switch (this.wStatus) {
      case watchStatus.Completed:
        {
          return "Completed";
        }
      case watchStatus.InProgress:
        {
          return "In-progress";
        }
      default:
        {
          return "None";
        }
    }
  }

  String getRuntime() {
    return this.runtime.length == 0 ? "None" : kGetShortcut(this.runtime);
  }

  String getAiringYear() {
    return this.airingYear.length == 0
        ? "None"
        : kGetYearShortcut(this.airingYear);
  }

  String getGenre() {
    return this.genre.length == 0 ? "None" : kGetShortcut(this.genre);
  }
}
