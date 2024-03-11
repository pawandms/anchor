
import 'package:anchor_getx/data/enums/EntityType.dart';
import 'package:anchor_getx/data/models/channel/UserChannel.dart';
import 'package:anchor_getx/data/models/message/ApiMessage.dart';

import '../enums/EventEntityType.dart';
import '../enums/EventType.dart';

class Event{
  late int eventId;
  late EventType type;
  late EventEntityType entity;
  late String entityId;
  late String author;
  late UserChannel? channel;
  late ApiMessage? message;
  late DateTime actionDate;

  Event({
    required this.eventId,
    required this.type,
    required this.entity,
    required this.entityId,
    required this.author,
    this.channel,
    this.message,
    required this.actionDate,
  });

  @override
  String toString() {
    return 'Event{eventId: $eventId, type: $type, entity: $entity, entityId: $entityId, author: $author, channel: $channel, message: $message, actionDate: $actionDate}';
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': this.eventId,
      'type': this.type,
      'entity': this.entity,
      'entityId': this.entityId,
      'author': this.author,
      'channel': this.channel,
      'message': this.message,
      'actionDate': this.actionDate,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventId: map["eventId"],
      type: EventTypeExtension.getType(map["type"]),
      entity: EventEntityTypeExtension.getType(map["entity"]),
      entityId: map["entityId"],
      author: map["author"],
      channel: map["channel"] == null ? null : UserChannel.fromMap(map["channel"]),
      message: map["message"] == null ? null : ApiMessage.fromMap(map["message"]),
      actionDate: DateTime.parse(map["actionDate"]),
    );
  }
//
}