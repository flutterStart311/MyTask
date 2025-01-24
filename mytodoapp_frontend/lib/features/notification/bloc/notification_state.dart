part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

class NotificationsFetchingState extends NotificationState {}

class NotificationFetchingSuccessState extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationFetchingSuccessState({required this.notifications});
}

class NotificationFetchingErrorState extends NotificationState {
  final String error;
  NotificationFetchingErrorState({required this.error});
}
