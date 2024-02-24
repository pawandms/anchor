enum ChannelSubscriptionType {
  Free,
  MonthlySubscription,
  DailySubscription,
  PayPerView,

}

extension ChannelTypeExtension on ChannelSubscriptionType {
  static final Map<String, ChannelSubscriptionType> _map = {
    'Free': ChannelSubscriptionType.Free,
    'MonthlySubscription': ChannelSubscriptionType.MonthlySubscription,
    'DailySubscription': ChannelSubscriptionType.DailySubscription,
    'PayPerView': ChannelSubscriptionType.PayPerView,

  };

  String? get value {
    switch (this) {
      case ChannelSubscriptionType.Free:
        return 'Free';
      case ChannelSubscriptionType.MonthlySubscription:
        return 'MonthlySubscription';
      case ChannelSubscriptionType.DailySubscription:
        return 'DailySubscription';
      case ChannelSubscriptionType.PayPerView:
        return 'PayPerView';
      default:
        return null;
    }
  }

  static ChannelSubscriptionType? getType(String type) {
    return _map[type];
  }
}

