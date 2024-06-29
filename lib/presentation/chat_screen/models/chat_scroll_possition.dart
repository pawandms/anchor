

class ChatScrollPosition{
  late List<int> curIndexs =List.empty(growable: true);
  late List<int> preIndexs = List.empty(growable: true);
  late int curMin;
  late int curMax;
  late int preMin;
  late int preMax;
  late DateTime crDate;
  late DateTime modDate;
  bool loading = false;
  bool initFlag = false;
  late String direction = 'NA';
  late int totalPages = 0;
  late int curPage = 0;
  late int currItemCount = 0;
  late int totalItemCount = 0;
  ChatScrollPosition({
   // required this.start_index,
    //required this.end_index,
   // this.direction,
    required this.initFlag,
    //required this.crDate,
    //required this.modDate
  
  });
}