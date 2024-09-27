package io.ionic.starter.extensions

import android.util.Log
import io.ionic.starter.data.models.ApiResponse
import io.ionic.starter.data.models.DateValue

fun ApiResponse.getWeatherSymbol(): Int
{

    kotlin.runCatching {
        return getValueForParam("weather_symbol_1h:idx").toDouble().toInt()
    }

    return 0;
}

fun ApiResponse.getValueForParam(param: String): String
{
    if (this.data != null)
    {
        val parameters = data!!.data!![0].parameters
        for (i in parameters!!.indices)
        {
            val parameter = parameters[i]
            if (parameter.parameter == param)
            {
                return parameter.value.toString()
            }
        }
    }
    return ""
}


fun ApiResponse.getCurrentTemp(): String
{
    return getValueForParam("t_2m:C");
}

fun ApiResponse.getWindSpeed(): String
{
    return getValueForParam("wind_speed_10m:kmh")
}

fun ApiResponse.getCurrentFeelLikeTemp(): String
{
    return getValueForParam("t_apparent:C")
}

fun ApiResponse.get24hHighTemp(): String
{
    return getFirstCoordinatedValueForParam("t_max_2m_24h:C").second
}

fun ApiResponse.get24LowTemp(): String
{
    return getFirstCoordinatedValueForParam("t_min_2m_24h:C").second
}


fun ApiResponse.get24WindSpeed(): String
{
    return getFirstCoordinatedValueForParam("wind_speed_2m:kmh").second
}

fun ApiResponse.get24WindDirectionAngle(): String
{
    return getFirstCoordinatedValueForParam("wind_dir_2m:d").second
}

fun ApiResponse.get24Precip(): String
{
    return getFirstCoordinatedValueForParam("precip_24h:mm").second
}

fun ApiResponse.get24PrecipProbability(): String
{
    return getFirstCoordinatedValueForParam("prob_precip_24h:p").second
}

fun ApiResponse.get6hoursForeCastTemp(): List<DateValue>
{
    return getListCoordinatedValueForParam("t_2m:C")
}
fun ApiResponse.get6hoursForeCastIcons(): List<DateValue>
{
    return getListCoordinatedValueForParam("weather_symbol_1h:idx")
}


fun ApiResponse.get5DaysForeCastIcons(): List<DateValue>
{
    return getListCoordinatedValueForParam("weather_symbol_24h:idx")
}


fun ApiResponse.get5DaysForeCastHighTemp(): List<DateValue>
{
    return getListCoordinatedValueForParam("t_max_2m_24h:C")
}


fun ApiResponse.get5DaysForeCastLowTemp(): List<DateValue>
{
    return getListCoordinatedValueForParam("t_min_2m_24h:C")
}




fun ApiResponse.getListCoordinatedValueForParam(param: String): List<DateValue>
{

    if (this.data != null)
    {
        for (i in data?.data ?: return emptyList())
        {

            if (i.parameter == param)
            {

                i.coordinates?.firstOrNull()?.dates?.let {
                    return it
                }
            }
        }
    }
    return emptyList()
}

fun ApiResponse.getFirstCoordinatedValueForParam(param: String): Pair<String, String>
{

    if (this.data != null)
    {


        for (i in data?.data ?: return Pair(
                "",
                ""
        ))
        {

            if (i.parameter == param)
            {
                i.coordinates?.firstOrNull()?.dates?.firstOrNull()?.let {
                    return Pair(
                            it.date!!,
                            it.value.toString()
                    )
                }
            }
        }
    }
    return Pair(
            "",
            ""
    )
}