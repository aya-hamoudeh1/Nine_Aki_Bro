import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/models/notification_model.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  final supabase = Supabase.instance.client;

  Future<void> fetchNotifications(String userId) async {
    try {
      emit(NotificationLoading());

      final response = await supabase
          .from('notifications')
          .select()
          .eq('notifications_id', userId)
          .order('created_at', ascending: false);

      final notifications = (response)
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      emit(NotificationSuccess(notifications));
    } catch (e) {
      log(e.toString());
      emit(NotificationError());
    }
  }
}
