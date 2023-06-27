class GeneralSettings {
  String language;
  String currency;
  String country;

  GeneralSettings(
      {required this.country, required this.currency, required this.language});
  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'currency': currency,
      'country': country,
    };
  }
}

class NotificationsSettings {
  int notifications;

  NotificationsSettings({required this.notifications});
  Map<String, dynamic> toMap() {
    return {
      'notifications': notifications,
    };
  }
}

class SettingsModel {
  int id;
  List<NotificationsSettings> notifications;
  List<GeneralSettings> general;
  SettingsModel(
      {required this.general, required this.notifications, required this.id});
  Map<String, dynamic> toMap() {
    return {'notifications': notifications, 'general': general, 'id': id};
  }
}
