
import 'ChannelMsg.dart';

class ChnlMsgResp{
  late List<ChannelMsg> content = [];

  // Page Details
  late int totalPages = 0;
  late int number = 0;
  late bool first = false;
  late bool last = false;
  late bool empty = false ;
  late int size = 0;
  // Element Details
  late int totalElements = 0;
  late int numberOfElements = 0;

ChnlMsgResp({
    required this.content,
    required this.totalPages,
    required this.number,
    required this.first,
    required this.last,
    required this.empty,
    required this.size,
    required this.totalElements,
    required this.numberOfElements,
  });

  Map<String, dynamic> toMap() {
    return {
      'content': this.content,
      'totalPages': this.totalPages,
      'number': this.number,
      'first': this.first,
      'last': this.last,
      'empty': this.empty,
      'size': this.size,
      'totalElements': this.totalElements,
      'numberOfElements': this.numberOfElements,
    };
  }

  factory ChnlMsgResp.fromMap(Map<String, dynamic> map) {
    return ChnlMsgResp(
      content: List.of(map["content"])
          .map((i) => ChannelMsg.fromMap(i))
          .toList(),
      totalPages: map['totalPages'] as int,
      number: map['number'] as int,
      first: map['first'] as bool,
      last: map['last'] as bool,
      empty: map['empty'] as bool,
      size: map['size'] as int,
      totalElements: map['totalElements'] as int,
      numberOfElements: map['numberOfElements'] as int,
    );
  }


}