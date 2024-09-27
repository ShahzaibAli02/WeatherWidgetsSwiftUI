package io.ionic.starter

import android.appwidget.AppWidgetManager
import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import com.google.gson.Gson
import io.ionic.starter.data.remote.ApiHandler
import io.ionic.starter.data.constants.Constants
import io.ionic.starter.data.constants.SharedKeys
import io.ionic.starter.data.localstorage.SharedPref
import io.ionic.starter.data.models.RequestBody
import io.ionic.starter.data.models.Result
import io.ionic.starter.data.models.Weather
import io.ionic.starter.extensions.get24LowTemp
import io.ionic.starter.extensions.get24Precip
import io.ionic.starter.extensions.get24PrecipProbability
import io.ionic.starter.extensions.get24WindDirectionAngle
import io.ionic.starter.extensions.get24WindSpeed
import io.ionic.starter.extensions.get24hHighTemp
import io.ionic.starter.extensions.get5DaysForeCastHighTemp
import io.ionic.starter.extensions.get5DaysForeCastIcons
import io.ionic.starter.extensions.get5DaysForeCastLowTemp
import io.ionic.starter.extensions.get6hoursForeCastIcons
import io.ionic.starter.extensions.get6hoursForeCastTemp
import io.ionic.starter.extensions.getCurrentFeelLikeTemp
import io.ionic.starter.extensions.getCurrentTemp
import io.ionic.starter.extensions.getWeatherSymbol
import io.ionic.starter.extensions.getWindSpeed
import io.ionic.starter.utils.AlarmHandler
import io.ionic.starter.utils.DateTime
import io.ionic.starter.utils.LocationManager
import io.ionic.starter.utils.Utils
import io.ionic.starter.widgets.LargeWeatherWidget
import io.ionic.starter.widgets.MediumWeatherWidget
import io.ionic.starter.widgets.SmallWeatherWidgetA
import io.ionic.starter.widgets.SmallWeatherWidgetB
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import java.util.Date


class WidgetService : BroadcastReceiver()
{
    private var sharedPref: SharedPref? = null
    private var locationManager: LocationManager? = null

    private val TAG = "WidgetService"

    override fun onReceive(context: Context, intent: Intent)
    {


        AlarmHandler.isAlarmSet = false
        sharedPref = SharedPref(context)
        locationManager = LocationManager(context)

        doAction(context)

    }

    private fun doAction(context: Context)
    { //Cancellation exception
        val handler = CoroutineExceptionHandler { _, exception ->
            exception.printStackTrace()
            updateWidgets(
                    context,
                    Bundle().Error(
                            Result<Any>(
                                    Constants.ERROR_EXCEPTION,
                                    R.drawable.ic_error,
                                    exception.cause.toString(),
                                    ""
                            )
                    )
            )
        }



        CoroutineScope(Dispatchers.Main + handler).launch {


            if (!sharedPref!!.hasSavedLocation() || Utils.isNeedUpdateLocation(context))
            {
                Log.d(
                        TAG,
                        "Updating Location: "
                )
                val result = locationManager?.getLocation()
                if (result!!.errorCode != -1)
                {
                    updateWidgets(
                            context,
                            Bundle().Error(result)
                    )
                    return@launch

                }
                sharedPref!!.setLong(SharedKeys.SHARED_KEY_LOCATION_DATE, Date().time)
                sharedPref!!.setString(
                        SharedKeys.SHARED_KEY_LAT_LNG,
                        result.data
                )
            }


            val defferedCurrentTimeApiResponse = async {
                ApiHandler.loadRouteQueryApi(context,
                        RequestBody().apply {
                            parameters = listOf(
                                    "weather_symbol_1h:idx",
                                    "t_2m:C",
                                    "t_apparent:C",
                            )
                            location = listOf(sharedPref!!.savedLocation!!)
                            date = DateTime.currentDateTimeActual

                        })
            }


            val defferedDailyApiResponse = async {
                ApiHandler.loadPublicQueryApi(context,
                        RequestBody().apply {
                            parameters = listOf(
                                    "weather_symbol_24h:idx",
                                    "t_max_2m_24h:C",
                                    "t_min_2m_24h:C",
                                    "wind_speed_2m:kmh",
                                    "wind_dir_2m:d",
                                    "precip_24h:mm",
                                    "prob_precip_24h:p"
                            )
                            resolution = "PT24H"
                            startdate = DateTime.currentDateTime
                            enddate = DateTime.addDays(5)
                            coordinate = sharedPref!!.savedLocation!!
                        })
            }


            val defferedHourlyApiResponse = async {
                ApiHandler.loadPublicQueryApi(context,
                        RequestBody().apply {
                            parameters = listOf(
                                    "weather_symbol_1h:idx",
                                    "t_2m:C",
                            )
                            resolution = "PT1H"
                            startdate = DateTime.currentDateTime
                            enddate = DateTime.addDays(2)
                            coordinate = sharedPref!!.savedLocation!!


                        })
            }


            val hourlyTimeApiResponse = defferedHourlyApiResponse.await()
            val currentTimeApiResponse = defferedCurrentTimeApiResponse.await()
            val dailyApiResponse = defferedDailyApiResponse.await()


            val errorResponse = when
            {
                currentTimeApiResponse.errorCode != -1 -> currentTimeApiResponse
                hourlyTimeApiResponse.errorCode != -1 -> hourlyTimeApiResponse
                dailyApiResponse.errorCode != -1 -> dailyApiResponse
                else -> null
            }


            errorResponse?.let {

                if (it.errorCode != Constants.ERROR_NO_INTERNET || sharedPref!!.hasSavedWeather()
                        .not()
                )
                {
                    updateWidgets(
                            context,
                            Bundle().Error(it)
                    )
                    return@launch
                }
            }


            val weather = if (errorResponse?.errorCode == Constants.ERROR_NO_INTERNET && sharedPref!!.hasSavedWeather())
            {
                Gson().fromJson(
                        sharedPref!!.savedWeather,
                        Weather::class.java
                )

            } else Weather().apply {
                weatherSymbol = currentTimeApiResponse.data?.getWeatherSymbol() ?: 0
                currentTemperature = currentTimeApiResponse.data?.getCurrentTemp()
                currentFeelLikeTemp = currentTimeApiResponse.data?.getCurrentFeelLikeTemp()
                windSpeed = currentTimeApiResponse.data?.getWindSpeed()

                _24hHighTemp = dailyApiResponse.data?.get24hHighTemp()
                _24LowTemp = dailyApiResponse.data?.get24LowTemp()
                _24LowTemp = dailyApiResponse.data?.get24LowTemp()

                _24WindSpeed = dailyApiResponse.data?.get24WindSpeed()
                _24WindDirection = dailyApiResponse.data?.get24WindDirectionAngle()
                _24Precip = dailyApiResponse.data?.get24Precip()
                _24PrecipProb = dailyApiResponse.data?.get24PrecipProbability()


                _6hoursForeCastTemp = hourlyTimeApiResponse.data?.get6hoursForeCastTemp()
                _6hoursForeCastIcons = hourlyTimeApiResponse.data?.get6hoursForeCastIcons()


                _5DaysForeCastIcons = dailyApiResponse.data?.get5DaysForeCastIcons()
                _5DaysForeCastHighTemp = dailyApiResponse.data?.get5DaysForeCastHighTemp()
                _5DaysForeCastLowTemp = dailyApiResponse.data?.get5DaysForeCastLowTemp()


            }

            sharedPref?.setString(
                    SharedKeys.SHARED_KEY_WEATHER,
                    Gson().toJson(weather)
            )

            updateWidgets(context,
                    Bundle().Location().apply {
                        putSerializable(
                                Constants.PARAM_WEATHER,
                                weather
                        );
                    })


        }
    }

    private fun <T> Bundle.Error(result: Result<T>): Bundle
    {
        putInt(
                Constants.PARAM_ERROR_CODE,
                result.errorCode
        )
        putInt(
                Constants.PARAM_ERROR_ICON,
                result.errorIcon
        )
        putString(
                Constants.PARAM_ERROR_MESSAGE,
                result.message
        )
        putString(
                Constants.PARAM_ERROR_DESCRIPTION,
                result.description
        )
        return this
    }


    private fun Bundle.Location(): Bundle
    {
        putString(
                Constants.PARAM_LOCATION,
                sharedPref!!.savedLocation
        )
        putString(
                Constants.PARAM_CITY,
                locationManager!!.getCityName(sharedPref!!.savedLocation!!)
        )
        return this
    }

    private fun updateWidget(context: Context, widgetClass: Class<*>)
    {

        updateWidget(
                context,
                Bundle().Location(),
                widgetClass
        )
    }

    private fun updateWidgets(context: Context, bundle: Bundle?)
    {
        updateWidget(
                context,
                bundle,
                SmallWeatherWidgetA::class.java
        )
        updateWidget(
                context,
                bundle,
                SmallWeatherWidgetB::class.java
        )
        updateWidget(
                context,
                bundle,
                MediumWeatherWidget::class.java
        )

        updateWidget(
                context,
                bundle,
                LargeWeatherWidget::class.java
        )

    }

    private fun updateWidget(context: Context, bundle: Bundle?, widgetClass: Class<*>)
    {
        val widgetIntent = Intent(
                context,
                widgetClass
        )
        widgetIntent.setAction(AppWidgetManager.ACTION_APPWIDGET_UPDATE)
        val ids = AppWidgetManager.getInstance(context).getAppWidgetIds(
                ComponentName(
                        context,
                        widgetClass
                )
        )
        widgetIntent.putExtra(
                AppWidgetManager.EXTRA_APPWIDGET_IDS,
                ids
        )
        if (bundle != null) widgetIntent.putExtras(bundle)
        context.sendBroadcast(widgetIntent)
    }
}
