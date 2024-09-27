package io.ionic.starter.utils

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.location.Geocoder
import android.location.Location
import android.location.LocationManager
import androidx.core.app.ActivityCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import com.google.android.gms.tasks.CancellationTokenSource
import io.ionic.starter.data.constants.Constants
import io.ionic.starter.R
import io.ionic.starter.data.models.Result
import kotlinx.coroutines.tasks.await
import java.io.IOException
import java.util.Locale

class LocationManager(private val context: Context)
{
    private var fusedLocationClient: FusedLocationProviderClient? = null

    suspend fun getLocation(): Result<String>
    {

        if (ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.ACCESS_FINE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.ACCESS_COARSE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED
        )
        {
            return Result(
                    Constants.ERROR_LOCATION_PERMISSION,
                    R.drawable.ic_location
                   ,
                    context.getString(R.string.enable_location_access),
                    context.getString(R.string.allow_access_for_weather_updates)
            )
        }

        if (!isGPSEnabled)
        {
            return Result(
                    Constants.ERROR_GPS_DISABLED,
                    R.drawable.ic_location
                    ,
                    context.getString(R.string.enable_location_access),
                    context.getString(R.string.allow_access_for_weather_updates)
            )
        }
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(context)

        try
        {
            var location: Location? = fusedLocationClient!!.lastLocation.await()
            if (location == null) location  = fusedLocationClient!!.getCurrentLocation(
                    Priority.PRIORITY_PASSIVE,
                    CancellationTokenSource().token,
            ).await()

            if (location != null)
            {
                return Result(
                        data = "${location.latitude},${location!!.longitude}"
                )

            }

            return Result(
                    Constants.ERROR_LOCATION_PERMISSION,
                    R.drawable.ic_location,
                    context.getString(R.string.failed_to_get_location),
                    ""
            )

        } catch (e: Exception)
        {
            e.printStackTrace()
            return Result(
                    Constants.ERROR_LOCATION_PERMISSION,
                    R.drawable.ic_location,
                    e.message?:"Location Error",
                    ""
            )
        }

    }


    private val isGPSEnabled: Boolean
        get()
        {
            val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
        }

    fun getCityName(latLng: String): String
    {
        try
        {
            val arr = latLng.split(",".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
            val lat = arr[0].toDouble()
            val lng = arr[1].toDouble()
            return getCityName(
                    lat,
                    lng
            )
        } catch (e: Exception)
        {
            e.printStackTrace()
            return ""
        }
    }

    fun getCityName(latitude: Double, longitude: Double): String
    {
        val geocoder = Geocoder(
                context,
                Locale.getDefault()
        )
        try
        {
            val addresses = geocoder.getFromLocation(
                    latitude,
                    longitude,
                    1
            )
            if (addresses != null && !addresses.isEmpty())
            {
                val address = addresses[0]
                return address.locality
            }
        } catch (e: IOException)
        {
            e.printStackTrace()
        }
        return "Unknown City"
    }
}
