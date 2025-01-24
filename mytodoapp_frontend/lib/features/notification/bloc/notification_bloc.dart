import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mytodoapp_frontend/models/notification.dart';
import 'package:mytodoapp_frontend/services/notification_services.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationServices _notificationServices = NotificationServices();

  NotificationBloc() : super(NotificationInitial()) {
    on<FetchAllNotificationsEvent>(fetchAllNotificationsEvent);
  }

  FutureOr<void> fetchAllNotificationsEvent(
      FetchAllNotificationsEvent event, Emitter<NotificationState> emit) async {
    try {
      emit(NotificationsFetchingState());
      await _notificationServices.getAllNotifications();
      emit(NotificationFetchingSuccessState(
          notifications: _notificationServices.allNotifications));
    } catch (e) {
      emit(NotificationFetchingErrorState(error: e.toString()));
    }
  }
}
