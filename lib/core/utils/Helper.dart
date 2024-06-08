
import 'package:intl/intl.dart';

import '../../data/models/media/MediaInput.dart';
import '../../data/models/message/Attachment.dart';

class Helper{

  static  DateFormat _formatter = DateFormat('yyyy-MM-dd');

  static String getText(DateTime date) {
    final now = new DateTime.now();
    if (_formatter.format(now) == _formatter.format(date)) {
      return 'Today';
    } else if (_formatter
        .format(new DateTime(now.year, now.month, now.day - 1)) ==
        _formatter.format(date))   {
      return 'Yesterday';
    } else {
      return '${DateFormat.yMMMd().format(date)}';
    }
  }

  static List<Attachment> convertMediaInputToAttachment(List<MediaInput> mediaList, String createdBy)
  {
    List<Attachment> attachments = [];
    int atchId = 1;
    if(mediaList.isNotEmpty)
     {
       mediaList.forEach((element) {

         Attachment attachment = new Attachment(id: atchId.toString(), type: element.type, name: element.file!.name, extension: 'na',
             bucketName: 'NA', contentID: 'NA', sizeInBytes: 0, createdBy: createdBy, createdOn: DateTime.now(), modifiedBy: createdBy, modifiedOn: DateTime.now());
        // attachment.localInput = element;
         attachments.add(attachment);
         atchId++;
       });
     }

    return attachments;
  }
}