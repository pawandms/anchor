
import 'dart:async';

import 'package:anchor_getx/data/models/message/ApiMessage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

class ChatTimeline extends StatefulWidget {
  const ChatTimeline({
    super.key,
    required this.messages,
    required this.localUserTheme,
    required this.remoteUserTheme,
    this.onPageTopScrollFunction,
    required this.myId,
  });

  final List<ApiMessage> messages;
  final Future<bool> Function()? onPageTopScrollFunction;
  final ThemeData localUserTheme;
  final ThemeData remoteUserTheme;
  final String myId;

  @override
  State<ChatTimeline> createState() => _ChatTimelineState(myId);
}


class _ChatTimelineState extends State<ChatTimeline> {
  final ScrollController _scrollController = ScrollController();
  late final String myId;

  _ChatTimelineState(String myID)
  {
    this.myId = myID;
  }
  @override
  void initState() {
    _scrollController.addListener(onUserScrolls);
    super.initState();
  }

  bool keepFetchingData = true;
  Completer<bool>? _scrollCompleter;
  Future<void> onUserScrolls() async {
    if (!keepFetchingData) return;
    if (widget.onPageTopScrollFunction == null) return;
    if (!(_scrollCompleter?.isCompleted ?? true)) return;

    double
    screenSize = MediaQuery.of(context).size.height,
        scrollLimit = _scrollController.position.maxScrollExtent,
        missingScroll = scrollLimit - screenSize,
        scrollLimitActivation = scrollLimit - missingScroll * 0.05;

    if (_scrollController.position.pixels < scrollLimitActivation) return;
    if (!(_scrollCompleter?.isCompleted ?? true)) return;

    _scrollCompleter = Completer();
    keepFetchingData = await widget.onPageTopScrollFunction!();
    _scrollCompleter!.complete(keepFetchingData);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      radius: const Radius.circular(15),
      child: GroupedListView<ApiMessage, DateTime>(
        controller: _scrollController,
        elements: widget.messages,
        order: GroupedListOrder.DESC,
        sort: true,
        reverse: true,
        floatingHeader: true,
        useStickyGroupSeparators: true,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        groupBy: (ApiMessage element) => DateTime(
          element.createdOn.year,
          element.createdOn.month,
          element.createdOn.day,
        ),
        groupHeaderBuilder: (element) =>
            GroupHeaderDate(date: element.createdOn),
      /*
        interdependentItemBuilder: (
            context,
            ApiMessage? previousElement,
            ApiMessage currentElement,
            ApiMessage? nextElement,

            ) =>
            Theme(
              data: currentElement.createdOn == myId
                  ? widget.localUserTheme
                  : widget.remoteUserTheme,
              child: MessageBox(
                  context: context,
                  previousElement: previousElement,
                  currentElement: currentElement,
                  nextElement: nextElement,
                 myId: myId,

              ),
            ),
        */
      ),
    );
  }
}

class GroupHeaderDate extends StatelessWidget {
  final DateTime date;

  const GroupHeaderDate({
    required this.date,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0
            ),
            child: Text(
              DateFormat.yMMMd().format(date),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.context,
    required this.previousElement,
    required this.currentElement,
    required this.nextElement,
    required this.myId,
  });

  final BuildContext context;
  final ApiMessage? previousElement;
  final ApiMessage currentElement;
  final ApiMessage? nextElement;
  final String myId;

  @override
  Widget build(BuildContext context) {
    bool
    displayUserName = true,
        displayAvatar = true;

    if (currentElement.createdOn == myId){
      displayUserName = false;
    } else

    if (nextElement == null){
      displayUserName = true;
    } else

    if (
    DateUtils.dateOnly(currentElement.createdOn) !=
        DateUtils.dateOnly(nextElement!.createdOn)
    ){
      displayUserName = true;
    } else

    if (nextElement!.createdBy != myId){
      displayUserName = false;
    }

    displayAvatar = displayUserName;
    //displayUserName = false;

    return Row(
      mainAxisAlignment: currentElement.createdBy == myId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (displayAvatar)
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blueAccent,
              child: const Icon(
                  Icons.person,
                  color: Colors.white
              ),
            ),
          ),
        if (!displayAvatar)
          const SizedBox(width: 40),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: currentElement.createdBy == myId
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (displayUserName)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Text(
                  '${currentElement.createdBy}:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.blueAccent
                  ),
                ),
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.76,
              child: Align(
                alignment: currentElement.createdBy == myId
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  elevation: 4.0,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(18.0),
                        topRight: const Radius.circular(18.0),
                        topLeft: Radius.circular(
                            currentElement.createdBy == myId ? 18.0 : 0
                        ),
                        bottomRight: Radius.circular(
                            currentElement.createdBy == myId ? 0 : 18.0
                        ),
                      )
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 24.0),
                        child: Text(currentElement.body),
                      ),
                      Positioned(
                          bottom: 4,
                          right: 8,
                          child: Text(
                            DateFormat.Hm().format(currentElement.createdOn),
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}