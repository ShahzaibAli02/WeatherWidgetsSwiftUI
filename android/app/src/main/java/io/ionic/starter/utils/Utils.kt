package io.ionic.starter.utils

import android.content.Context
import android.util.Log
import io.ionic.starter.data.constants.Constants
import io.ionic.starter.data.constants.SharedKeys
import io.ionic.starter.data.localstorage.SharedPref
import io.ionic.starter.data.models.DateValue
import java.util.Date
import java.util.Locale

object  Utils
{


    fun getWindDirectionFromAngle(angle: Float, locale: Locale = Locale.getDefault()): String {
        // Define wind directions in English
        Log.d(
                "TAG",
                "getWindDirectionFromAngle: ANGLE "+angle
        )
        val directionsEnglish = listOf("N", "NW", "W", "SW", "S", "SE", "E", "NE")
        // Define wind directions in Arabic
        val directionsArabic = listOf("شمالية", "شمالية غربية", "غربية", "جنوبية غربية", "جنوبية", "جنوبية شرقية", "شرقية", "شمالية شرقية")

        // Determine which set of directions to use based on the locale
        val directions = if (locale.language == "ar") directionsArabic else directionsEnglish

        return when {
            angle == -999f -> if(locale.language == "ar") "غير متاح" else "N/A"
            angle <= 22.5 -> directions[0] // "N" or "شمال"
            angle <= 67.5 -> directions[1] // "NW" or "شمال غرب"
            angle <= 112.5 -> directions[2] // "W" or "غرب"
            angle <= 157.5 -> directions[3] // "SW" or "جنوب غرب"
            angle <= 202.5 -> directions[4] // "S" or "جنوب"
            angle <= 247.5 -> directions[5] // "SE" or "جنوب شرق"
            angle <= 292.5 -> directions[6] // "E" or "شرق"
            angle <= 337.5 -> directions[7] // "NE" or "شمال شرق"
            else -> "شمالية"
        }
    }

    // Example usage:
    fun main() {
        val currentLocale = Locale.getDefault() // or Locale("ar") for Arabic
        println(getWindDirectionFromAngle(45f, currentLocale))  // Example usage
    }


    fun isNeedUpdateLocation(context: Context):Boolean
    {
        val sharedPref = SharedPref(context)
        val timeDifferenceInMilis=Date().time - sharedPref.getLong(SharedKeys.SHARED_KEY_LOCATION_DATE,0)
        return timeDifferenceInMilis>= Constants.LOCATION_UPDATE_TIME
    }
    fun getWindDirectionFromAngle(angle:String?):String
    {
        kotlin.runCatching {
            return getWindDirectionFromAngle(angle?.toFloat()?:return "")
        }.onFailure {
            Log.i(
                    "Utils",
                    "getWindDirectionFromAngle() ${it.message}"
            )
        }
        return ""
    }

     fun getCurrentIndex(_6hoursForeCastTemp: List<DateValue>?): Int
    {
        val currentAMPM = DateTime.currentAMPM()
        _6hoursForeCastTemp?.forEachIndexed {index, it->
            val amPM=DateTime.convertToAmPm(it.date)

            if(amPM == currentAMPM)
                return index

        }
        return 0
    }

}