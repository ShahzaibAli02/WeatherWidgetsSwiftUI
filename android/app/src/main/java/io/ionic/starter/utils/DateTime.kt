package io.ionic.starter.utils

import android.util.Log
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale
import java.util.TimeZone

object DateTime
{

    private val TAG="DateTime"

    fun getTimeZoneOffsetInHours(): Int {
        val timeZone = TimeZone.getDefault()
        val offsetMillis = timeZone.rawOffset + if (timeZone.inDaylightTime(Date())) timeZone.dstSavings else 0
        val offsetHours = offsetMillis / 3600000
        return offsetHours
    }
    val currentDateTimeActual: String
        get()
        {
            val sdf = SimpleDateFormat(
                    "yyyy-MM-dd'T'HH:mm:ss'Z'",
                    Locale.ENGLISH
            )

            sdf.timeZone = TimeZone.getTimeZone("UTC")
            return sdf.format(Calendar.getInstance().time)
        }


    val currentDateTime: String
        get()
        {
            val sdf = SimpleDateFormat(
                    "yyyy-MM-dd'T'HH:mm:ss'Z'",
                    Locale.ENGLISH
            )

            sdf.timeZone = TimeZone.getTimeZone("UTC")

            // Get the current date
            val calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"))
            var days = 0
            val hours =  24-getTimeZoneOffsetInHours()
            if (hours<24)
                days = -1

            calendar.set(Calendar.HOUR_OF_DAY, hours)
            calendar.set(Calendar.MINUTE, 0)
            calendar.set(Calendar.SECOND, 0)
            calendar.set(Calendar.MILLISECOND, 0)
            calendar.add(Calendar.DAY_OF_YEAR,days)

            return sdf.format(calendar.time)
        }





    fun currentAMPM(): String {


        runCatching {


            return SimpleDateFormat("h a",  Locale.getDefault()).format(Date())
        }
            .onFailure {
                Log.i(
                        TAG,
                        "Failed to parse date convertToAmPm ${it.message}"
                )
                it.printStackTrace()
            }

        return "";

    }

    fun convertToAmPm(dateString: String?): String {

        if(dateString==null)
            return ""
        runCatching {

            val sdf = SimpleDateFormat(
                    "yyyy-MM-dd'T'HH:mm:ss'Z'",
                    Locale.ENGLISH
            )
            val date = parseDate(dateString)!!
            val calendar = Calendar.getInstance()
            calendar.time = date
            calendar.add(Calendar.HOUR_OF_DAY, getTimeZoneOffsetInHours())

            return SimpleDateFormat("h a",  Locale.getDefault()).format(calendar.time)
        }
            .onFailure {
                Log.i(
                        TAG,
                        "Failed to parse date convertToAmPm ${it.message}"
                )
                it.printStackTrace()
            }

        return "";

    }

    fun toDayName(dateString: String?): String {

        if(dateString==null)
            return ""
        runCatching {
            val date = parseDate(dateString)!!
            val calendar = Calendar.getInstance()
            calendar.time = date
            calendar.add(Calendar.HOUR_OF_DAY, getTimeZoneOffsetInHours())
            return  SimpleDateFormat("EEE",  Locale.getDefault()).format(calendar.time)
        }
            .onFailure {
                Log.i(
                        TAG,
                        "Failed to parse date convertToAmPm ${it.message}"
                )
                it.printStackTrace()
            }

        return "";

    }
    private fun parseDate(dateString:String): Date?
    {
        kotlin.runCatching {

            return  SimpleDateFormat(
                "yyyy-MM-dd'T'HH:mm:ss'Z'",
                Locale.ENGLISH
        ).parse(dateString)

        }
        return Date()
    }
    fun toShortDate(dateString: String?): String {

        if(dateString==null)
            return ""
        runCatching {

            val date = parseDate(dateString)!!
            val calendar = Calendar.getInstance()
            calendar.time = date
            calendar.add(Calendar.HOUR_OF_DAY, getTimeZoneOffsetInHours())
            val outputFormatter = SimpleDateFormat("dd/MM",  Locale.getDefault())
            return outputFormatter.format(calendar.time)
        }
            .onFailure {
                Log.i(
                        TAG,
                        "Failed to parse date convertToAmPm ${it.message}"
                )
                it.printStackTrace()
            }

        return "";

    }
    fun addDays(days:Int) : String
    {
        val sdf = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", Locale.ENGLISH)
        val date=sdf.parse(currentDateTime)?:Date()

        val calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"))
        calendar.time=date
        calendar.add(Calendar.DAY_OF_YEAR, days)


        return sdf.format(calendar.time)

    }
}
