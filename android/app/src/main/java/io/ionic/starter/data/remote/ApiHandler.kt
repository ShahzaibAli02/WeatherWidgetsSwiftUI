package io.ionic.starter.data.remote

import android.content.Context
import android.util.Log
import com.google.gson.Gson
import io.ionic.starter.BuildConfig
import io.ionic.starter.data.constants.Constants
import io.ionic.starter.R
import io.ionic.starter.data.models.ApiResponse
import io.ionic.starter.data.models.RequestBody
import io.ionic.starter.data.models.Result

object ApiHandler
{
    private val apiService = RetrofitFactory.makeRetrofitService()
    private val TAG = "ApiHandler"
    suspend fun loadRouteQueryApi(context: Context, requestBody: RequestBody): Result<ApiResponse?>
    {

        try
        {
            val apiResponse = apiService.routeQuery(
                    "Basic ${BuildConfig.AUTHORIZATION}",
                    requestBody
            )
            return Result(apiResponse)
        } catch (e: Exception)
        {
            e.printStackTrace()
            if(e is java.net.UnknownHostException || e is java.net.SocketTimeoutException)
            {
                return Result(
                        Constants.ERROR_NO_INTERNET,
                        context.getString(R.string.check_your_internet_connection),null)
            }
            return Result(Constants.ERROR_API,e.message?: context.getString(R.string.error_connecting_with_server),null)
        }

    }

    suspend fun loadPublicQueryApi(context: Context,requestBody: RequestBody): Result<ApiResponse?>
    {


        try
        {
            val apiResponse = apiService.publicQuery(
                    "Basic ${BuildConfig.AUTHORIZATION}",
                    requestBody
            )

            Log.d(
                    TAG,
                    "PUBLIC QUERY API RESPONSE: "+ Gson().toJson(apiResponse)
            )

            return Result(apiResponse)
        } catch (e: Exception)
        {
            e.printStackTrace()
            if(e is java.net.UnknownHostException || e is java.net.SocketTimeoutException)
            {
                return Result(Constants.ERROR_NO_INTERNET, context.getString(R.string.check_your_internet_connection),null)
            }
            return Result(
                    Constants.ERROR_API,
                    e.message ?: "",
                    null
            )
        }

    }
}
