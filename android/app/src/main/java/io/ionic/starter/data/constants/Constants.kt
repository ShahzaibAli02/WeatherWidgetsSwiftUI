package io.ionic.starter.data.constants

import io.ionic.starter.R
import io.ionic.starter.data.models.WeatherSymbol

object Constants
{




    //TIME FOR WIDGET TO UPDATE IN MILLISECONDS
    public val WIDGET_UPDATE_TIME = ((5 * 60) * 1000).toLong()


    //Time after get new  location 10 minutes
    public val LOCATION_UPDATE_TIME = ((10 * 60) * 1000).toLong()


    var PARAM_CITY: String = "city"
    var PARAM_LOCATION: String = "location"
    var PARAM_ERROR_CODE: String = "error_code"
    var PARAM_ERROR_MESSAGE: String = "error_message"
    var PARAM_ERROR_DESCRIPTION: String = "error_description"
    var PARAM_ERROR_ICON: String = "error_icon"

    var PARAM_WEATHER: String = "weather"


    //ERROR CODES
    var ERROR_LOCATION: Int = 11
    var ERROR_LOCATION_PERMISSION: Int = 12
    var ERROR_GPS_DISABLED: Int = 13
    var ERROR_API: Int = 14
    var ERROR_NO_INTERNET: Int = 16
    var ERROR_EXCEPTION: Int = 15




    val weatherWhiteIconsData: HashMap<Int, WeatherSymbol> = hashMapOf(
            0 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_0
            ),
            1 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_1
            ),
            2 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_2
            ),
            3 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_3
            ),
            4 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_4
            ),
            5 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_5
            ),
            6 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_6
            ),
            7 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_7
            ),
            8 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_8
            ),
            9 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_9
            ),
            10 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_10
            ),
            11 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_11
            ),
            12 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_12
            ),
            13 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_13
            ),
            14 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_14
            ),
            15 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_15
            ),
            16 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_16
            ),
            101 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_101
            ),
            102 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_102
            ),
            103 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_103
            ),
            104 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_104
            ),
            105 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_105
            ),
            106 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_106
            ),
            107 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_107
            ),
            108 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_108
            ),
            109 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_109
            ),
            110 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_110
            ),
            111 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_111
            ),
            112 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_112
            ),
            113 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_113
            ),
            114 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_114
            ),
            115 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_115
            ),
            116 to WeatherSymbol(
                    R.string.nan,
                    R.drawable.white_116
            )
    )

    val weatherData: HashMap<Int, WeatherSymbol> = hashMapOf(
            0 to WeatherSymbol(
                    R.string.weather_code_not_determined,
                    R.drawable.baseline_broken_image_24
            ),
            1 to WeatherSymbol(
                    R.string.clear_sky,
                    R.drawable._1
            ),
            101 to WeatherSymbol(
                    R.string.clear_sky,
                    R.drawable._101
            ),
            2 to WeatherSymbol(
                    R.string.light_clouds,
                    R.drawable._2
            ),
            102 to WeatherSymbol(
                    R.string.light_clouds,
                    R.drawable._102
            ),
            3 to WeatherSymbol(
                    R.string.partly_cloudy,
                    R.drawable._3
            ),
            103 to WeatherSymbol(
                    R.string.partly_cloudy,
                    R.drawable._103
            ),
            4 to WeatherSymbol(
                    R.string.cloudy,
                    R.drawable._4
            ),
            104 to WeatherSymbol(
                    R.string.cloudy,
                    R.drawable._104
            ),
            5 to WeatherSymbol(
                    R.string.rain,
                    R.drawable._5
            ),
            105 to WeatherSymbol(
                    R.string.rain,
                    R.drawable._105
            ),
            6 to WeatherSymbol(
                    R.string.rain_and_snow_sleet,
                    R.drawable._6
            ),
            106 to WeatherSymbol(
                    R.string.rain_and_snow_sleet,
                    R.drawable._106
            ),
            7 to WeatherSymbol(
                    R.string.snow,
                    R.drawable._7
            ),
            107 to WeatherSymbol(
                    R.string.snow,
                    R.drawable._107
            ),
            8 to WeatherSymbol(
                    R.string.rain_shower,
                    R.drawable._8
            ),
            108 to WeatherSymbol(
                    R.string.rain_shower,
                    R.drawable._108
            ),
            9 to WeatherSymbol(
                    R.string.snow_shower,
                    R.drawable._9
            ),
            109 to WeatherSymbol(
                    R.string.snow_shower,
                    R.drawable._109
            ),
            10 to WeatherSymbol(
                    R.string.sleet_shower,
                    R.drawable._10
            ),
            110 to WeatherSymbol(
                    R.string.sleet_shower,
                    R.drawable._110
            ),
            11 to WeatherSymbol(
                    R.string.light_fog,
                    R.drawable._11
            ),
            111 to WeatherSymbol(
                    R.string.light_fog,
                    R.drawable._111
            ),
            12 to WeatherSymbol(
                    R.string.dense_fog,
                    R.drawable._12
            ),
            112 to WeatherSymbol(
                    R.string.dense_fog,
                    R.drawable._112
            ),
            13 to WeatherSymbol(
                    R.string.freezing_rain,
                    R.drawable._13
            ),
            113 to WeatherSymbol(
                    R.string.freezing_rain,
                    R.drawable._113
            ),
            14 to WeatherSymbol(
                    R.string.thunderstorms,
                    R.drawable._14
            ),
            114 to WeatherSymbol(
                    R.string.thunderstorms,
                    R.drawable._114
            ),
            15 to WeatherSymbol(
                    R.string.drizzle,
                    R.drawable._15
            ),
            115 to WeatherSymbol(
                    R.string.drizzle,
                    R.drawable._115
            ),
            16 to WeatherSymbol(
                    R.string.sandstorm,
                    R.drawable._16
            ),
            116 to WeatherSymbol(
                    R.string.sandstorm,
                    R.drawable._116
            )
    )
}
