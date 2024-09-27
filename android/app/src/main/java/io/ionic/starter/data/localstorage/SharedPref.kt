package io.ionic.starter.data.localstorage

import android.content.Context
import android.content.SharedPreferences
import io.ionic.starter.data.constants.SharedKeys

class SharedPref(context: Context)
{
    private val sharedPreferences: SharedPreferences = context.getSharedPreferences(
            context.packageName,
            Context.MODE_PRIVATE
    )


    fun getLong(key: String?,defValue: Long):Long
    {
        return sharedPreferences.getLong(
                key,
                defValue
        )
    }
    fun setLong(key: String?,value: Long)
    {
        sharedPreferences.edit().putLong(
                key,
                value
        ).apply()
    }

    fun getString(key: String?, defValue: String?): String?
    {
        return sharedPreferences.getString(
                key,
                defValue
        )
    }

    fun setString(key: String?, value: String?)
    {
        sharedPreferences.edit().putString(
                    key,
                    value
            ).apply()
    }

    fun hasSavedLocation(): Boolean
    {
        return savedLocation!!.isNotBlank()
    }
    fun hasSavedWeather(): Boolean
    {
        return savedWeather!!.isNotBlank()
    }

    val savedLocation: String?
        get() = getString(
                SharedKeys.SHARED_KEY_LAT_LNG,
                ""
        )

    val savedWeather: String?
        get() = getString(
                SharedKeys.SHARED_KEY_WEATHER,
                ""
        )
}
