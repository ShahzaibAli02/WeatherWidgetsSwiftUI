package io.ionic.starter.widgets

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.RemoteViews
import io.ionic.starter.MainActivity
import io.ionic.starter.utils.AlarmHandler
import io.ionic.starter.data.constants.Constants
import io.ionic.starter.utils.DateTime
import io.ionic.starter.R
import io.ionic.starter.data.localstorage.SharedPref
import io.ionic.starter.data.models.DateValue
import io.ionic.starter.data.models.Weather
import io.ionic.starter.data.models.WeatherSymbol
import io.ionic.starter.extensions.roundStringValue
import io.ionic.starter.utils.Utils

class MediumWeatherWidget : AppWidgetProvider()
{

    private val REQUEST_CODE = 12
    private val TAG = "MediumWeatherWidget"
    private var sharedPref: SharedPref? = null
    private var bundle: Bundle? = null
    fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int)
    {
        if (bundle == null) bundle = Bundle()
        val remoteViews = RemoteViews(
                context.packageName,
                R.layout.lyt_weather_widget_medium
        )
        val intent = Intent(context, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

        // Set the click handler for the widget
        remoteViews.setOnClickPendingIntent(R.id.root, pendingIntent)

        val city = bundle!!.getString(
                Constants.PARAM_CITY,
                ""
        )
        var weather: Weather? = null

        if (bundle!!.containsKey(Constants.PARAM_WEATHER))
        {
            weather = bundle!!.getSerializable(Constants.PARAM_WEATHER) as Weather?
        }

        if (bundle!!.getInt(
                    Constants.PARAM_ERROR_CODE,
                    0
            ) != 0
        )
        {
            remoteViews.setViewVisibility(
                    R.id.lytError,
                    View.VISIBLE
            )



            remoteViews.setTextViewText(
                    R.id.txtError,
                    bundle!!.getString(
                            Constants.PARAM_ERROR_MESSAGE,
                            "Unknown Error"
                    )
            )

            remoteViews.setImageViewResource(
                    R.id.imageError,
                    bundle!!.getInt(
                            Constants.PARAM_ERROR_ICON,
                            R.drawable.ic_error
                    )
            )
            remoteViews.setTextViewText(
                    R.id.txtErrorDesc,
                    bundle!!.getString(
                            Constants.PARAM_ERROR_DESCRIPTION,
                            "Unknown Error"
                    )
            )
        }



        if (weather != null)
        {

            val weatherSymbol = Constants.weatherData[weather.weatherSymbol] ?: WeatherSymbol(
                    R.string.weather_code_not_determined,
                    R.drawable.baseline_broken_image_24
            )
            remoteViews.setTextViewText(
                    R.id.txtCityName,
                    city
            )
            remoteViews.setTextViewText(
                    R.id.txtTemp,
                    weather.currentTemperature?.roundStringValue() + " ${getString(context,R.string.c)}"
            )
            remoteViews.setTextViewText(
                    R.id.txtFeelsLike,
                    getString(
                            context,
                            R.string.like_c
                    ) + " ${weather.currentFeelLikeTemp?.roundStringValue()}°"
            )
            remoteViews.setTextViewText(
                    R.id.txtWeather,
                    getString(
                            context,
                            weatherSymbol.description
                    )
            )

            remoteViews.setTextViewText(
                    R.id.txtTempHigh,
                    "${weather._24hHighTemp?.roundStringValue()}°"
            )
            remoteViews.setTextViewText(
                    R.id.txtLowTemp,
                    "${weather._24LowTemp?.roundStringValue()}°"
            )


            val currentIndex = Utils.getCurrentIndex( weather._6hoursForeCastTemp)
            remoteViews.setTextViewText(
                    R.id.txtWeatherTime0,
                    getString(
                            context,
                            R.string.now
                    )
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTime1,
                    DateTime.convertToAmPm(weather._6hoursForeCastTemp?.getOrNull(currentIndex+1)?.date)
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTime2,
                    DateTime.convertToAmPm(weather._6hoursForeCastTemp?.getOrNull(currentIndex+2)?.date)
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTime3,
                    DateTime.convertToAmPm(weather._6hoursForeCastTemp?.getOrNull(currentIndex+3)?.date)
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTime4,
                    DateTime.convertToAmPm(weather._6hoursForeCastTemp?.getOrNull(currentIndex+4)?.date)
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTime5,
                    DateTime.convertToAmPm(weather._6hoursForeCastTemp?.getOrNull(currentIndex+5)?.date)
            )


            remoteViews.setImageViewResource(
                    R.id.imgWeatherIcon0,
                    getWhiteWeatherIcon(weather._6hoursForeCastIcons?.getOrNull(currentIndex+0))
                    )

            remoteViews.setImageViewResource(
                    R.id.imgWeatherIcon1,
                    getWhiteWeatherIcon(weather._6hoursForeCastIcons?.getOrNull(currentIndex+1))
            )
            remoteViews.setImageViewResource(
                    R.id.imgWeatherIcon2,
                    getWhiteWeatherIcon(weather._6hoursForeCastIcons?.getOrNull(currentIndex+2))
            )
            remoteViews.setImageViewResource(
                    R.id.imgWeatherIcon3,
                    getWhiteWeatherIcon(weather._6hoursForeCastIcons?.getOrNull(currentIndex+3))
            )

            remoteViews.setImageViewResource(
                    R.id.imgWeatherIcon4,
                    getWhiteWeatherIcon(weather._6hoursForeCastIcons?.getOrNull(currentIndex+4))
            )

            remoteViews.setImageViewResource(
                    R.id.imgWeatherIcon5,
                    getWhiteWeatherIcon(weather._6hoursForeCastIcons?.getOrNull(currentIndex+5))
            )




            remoteViews.setTextViewText(
                    R.id.txtWeatherTemperature0,
                    "${
                        weather._6hoursForeCastTemp?.getOrNull(currentIndex+0)?.value.toString()
                            .roundStringValue()
                    }°"
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTemperature1,
                    "${
                        weather._6hoursForeCastTemp?.getOrNull(currentIndex+1)?.value.toString()
                            .roundStringValue()
                    }°"
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTemperature2,
                    "${
                        weather._6hoursForeCastTemp?.getOrNull(currentIndex+2)?.value.toString()
                            .roundStringValue()
                    }°"
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTemperature3,
                    "${
                        weather._6hoursForeCastTemp?.getOrNull(currentIndex+3)?.value.toString()
                            .roundStringValue()
                    }°"
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTemperature4,
                    "${
                        weather._6hoursForeCastTemp?.getOrNull(currentIndex+4)?.value.toString()
                            .roundStringValue()
                    }°"
            )
            remoteViews.setTextViewText(
                    R.id.txtWeatherTemperature5,
                    "${
                        weather._6hoursForeCastTemp?.getOrNull(currentIndex+5)?.value.toString()
                            .roundStringValue()
                    }°"
            )
            remoteViews.setImageViewResource(
                    R.id.imgWeather,
                    weatherSymbol.icon
            )
            remoteViews.setViewVisibility(
                    R.id.lytError,
                    View.GONE
            )
        }






        appWidgetManager.updateAppWidget(
                appWidgetId,
                remoteViews
        )

        val alarmHandler = AlarmHandler(context)
        alarmHandler.cancelAlarmManager(REQUEST_CODE)

        alarmHandler.setAlarmManager(
                REQUEST_CODE,
                if(weather==null) 0L else Constants.WIDGET_UPDATE_TIME
        )
    }

    fun getWhiteWeatherIcon(dateValue: DateValue?): Int
    {
        dateValue?.value?.let {
            return Constants.weatherWhiteIconsData.get(it.toInt())?.icon ?: R.drawable.white_0
        }
        return R.drawable.white_0
    }

    fun getString(context: Context, id: Int): String
    {

        kotlin.runCatching {
            return context.getString(id);
        }
        return ""
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    )
    {
        if (sharedPref == null) sharedPref = SharedPref(context)

        for (appWidgetId in appWidgetIds)
        {
            updateAppWidget(
                    context,
                    appWidgetManager,
                    appWidgetId
            )
        }
    }

    override fun onEnabled(context: Context)
    { // Implement if needed
        Log.d(
                TAG,
                "onEnabled: "
        )
    }

    override fun onReceive(context: Context, intent: Intent)
    {/*
        AppWidgetManager mgr = AppWidgetManager.getInstance(context);
        if (intent.getAction().equals(NewsWidget.TOAST_ACTION)) {
            String viewIndex = intent.getStringExtra("str");
            Uri uri = Uri.parse(viewIndex);
            Intent intent2 = new Intent(Intent.ACTION_VIEW, uri);
            intent2.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent2);
        }
        */
        this.bundle = intent.extras
        Log.d(
                TAG,
                "onReceive: "
        )
        super.onReceive(
                context,
                intent
        )
    }

    override fun onDisabled(context: Context)
    {
        Log.d(
                TAG,
                "onDisabled: "
        )
        val alarmHandler = AlarmHandler(context)
        alarmHandler.cancelAlarmManager(REQUEST_CODE)
    }
}