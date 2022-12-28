class NotificationModel {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  NotificationModel({
    required this.id,
    this.title,
    this.body,
    this.payload,
  });
}
