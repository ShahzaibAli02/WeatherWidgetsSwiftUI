package io.ionic.starter.utils;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

import java.util.Calendar;

import io.ionic.starter.WidgetService;

public class AlarmHandler {


  public static boolean isAlarmSet = false;
  private final Context context;

  private String TAG="AlarmHandler";
  public AlarmHandler(Context context) {
    this.context = context;
  }

  public void setAlarmManager(int requestCode,long time) {

//    if(isAlarmSet)
//    {
//      Log.i(TAG, "Alarm already set returning");
//      return;
//    }


    //cancel if have alarm already
//    cancelAlarmManager(requestCode);
    Log.i(TAG, "Trigger alarm after  "+time+" ms");
    Intent intent = new Intent(context, WidgetService.class);
    PendingIntent sender;
    sender = PendingIntent.getBroadcast(context, requestCode, intent, PendingIntent.FLAG_IMMUTABLE);
    AlarmManager am = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);

    //get current time and add 10 seconds
    Calendar c = Calendar.getInstance();
    long l = c.getTimeInMillis() + time;
    if (am != null) {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        am.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, l, sender);
      }
      else
        am.set(AlarmManager.RTC_WAKEUP, l, sender);
    }
    isAlarmSet = true;
  }
  public boolean isAlarmSet(int requestCode) {
    Intent intent = new Intent(context, WidgetService.class);
    PendingIntent pendingIntent = PendingIntent.getBroadcast(context, requestCode, intent, PendingIntent.FLAG_NO_CREATE | PendingIntent.FLAG_IMMUTABLE);
    return pendingIntent != null;
  }

  public void cancelAlarmManager(int requestCode) {
    Intent intent = new Intent(context, WidgetService.class);
    PendingIntent sender;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      sender = PendingIntent.getBroadcast(context, requestCode, intent, PendingIntent.FLAG_IMMUTABLE);
    } else {
      sender = PendingIntent.getBroadcast(context, requestCode, intent, 0);
    }
    AlarmManager am = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
    if (am != null) {
      am.cancel(sender);
    }
  }
}
