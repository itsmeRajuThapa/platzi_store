import 'dart:developer';

/// FUNC [getPaginationListData] : Return list of pagination data of type T
List<T> getPaginationListData<T>({
  required List<T> stateData,
  required bool isToRefresh,
  required dynamic l,
  required Function fromJson,
}) {
  try {
    /// check dynamic success data l type is map
    Map<String, dynamic> lData = l != null ? l['data'] : {};

    /// check dynamic success data l type is map
    /// check map contains data or not
    /// check data is type of list of not
    /// check list is empty or not
    if (lData.containsKey('data') &&
        lData['data'] is List &&
        List.of(lData['data']).isNotEmpty) {
      /// hold list of dynamic data
      List<dynamic> dynamicList = List.of(lData['data']);

      /// parse dynamic list data in the type of T data
      /// check dynamic list contains null data or not, if contains null data then ignore it
      List<T> parsedList = dynamicList
          .where((e) => e != null)
          .map<T>((e) => fromJson(e))
          .toList();

      /// if isToRefresh value is true, then make returnList value as empty else copy state data
      List<T> returnList = isToRefresh ? [] : [...stateData];

      /// if parsedList is not empty then add new data on return list
      if (parsedList.isNotEmpty) returnList.addAll(parsedList);
      return returnList;
    } else {
      log(":::GET PAGINATION DATA TYPE ::: $T ::: CASTING ERROR ::: SUCCESS DATA DOES NOT RETURN DATA ON STANDARD FORMAT :::");
      return stateData;
    }
  } catch (e) {
    log(":::GET PAGINATION DATA TYPE ::: $T ::: CASTING ERROR :::");
    return stateData;
  }
}

MetaModel getCurrentStatePage({required dynamic l}) {
  try {
    /// check dynamic success data l type is map
    Map<String, dynamic> lData = l != null ? l['data'] : {};
    if (lData.containsKey('meta') && Map.of(lData['meta']).isNotEmpty) {
      MetaModel meta = MetaModel.fromJson(lData['meta']);
      return meta.copyWith(currentPage: (meta.currentPage ?? 0) + 1);
    } else {
      log(":::GET CURRENT PAGE ::: CASTING ERROR :::");
      return MetaModel().copyWith(currentPage: 1, lastPage: 1, total: 0);
    }
  } catch (e) {
    log(":::GET CURRENT PAGE ::: CASTING ERROR :::");
    return MetaModel().copyWith(currentPage: 1, lastPage: 1, total: 0);
  }
}

List<T> getSuccessDataOnList<T>({
  required dynamic l,
  required Function fromJson,
}) {
  try {
    if (l['data'] != null &&
        l['data'] is List &&
        List.of(l['data']).isNotEmpty) {
      /// hold list of dynamic data
      List<dynamic> dynamicList = List.of(l['data']);

      /// parse dynamic list data in the type of T data
      /// check dynamic list contains null data or not, if contains null data then ignore it
      List<T> parsedList = dynamicList
          .where((e) => e != null)
          .map<T>((e) => fromJson(e))
          .toList();
      return parsedList;
    } else if (l['data'] != null &&
        l['data'] is List &&
        List.of(l['data']).isEmpty) {
      return [];
    } else {
      log(":::RETURN PARSING LIST ::: CASTING ERROR :::");
      return [];
    }
  } catch (e) {
    log(":::RETURN LIST ::: CASTING ERROR :::");
    return [];
  }
}

T? getSuccessDataOnMap<T>({
  required dynamic data,
  required Function fromJson,
}) {
  T? model;
  try {
    if (data is Map) {
      try {
        model = fromJson(data);
      } catch (e) {
        log(e.toString());
      }
    }
  } catch (e) {
    log(e.toString());
  }
  return model;
}

class MetaModel {
  MetaModel({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  MetaModel.fromJson(dynamic json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  MetaModel copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Links>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      MetaModel(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        links: links ?? this.links,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    map['from'] = from;
    map['last_page'] = lastPage;
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['path'] = path;
    map['per_page'] = perPage;
    map['to'] = to;
    map['total'] = total;
    return map;
  }
}

class Links {
  Links({
    this.url,
    this.label,
    this.active,
  });

  Links.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  dynamic url;
  String? label;
  bool? active;

  Links copyWith({
    dynamic url,
    String? label,
    bool? active,
  }) =>
      Links(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['active'] = active;
    return map;
  }
}
