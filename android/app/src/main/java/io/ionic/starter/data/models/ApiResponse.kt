package io.ionic.starter.data.models

import android.util.Log
import java.io.Serializable

class ApiResponse : Serializable
{
    // Getters and setters
    var isSuccess: Boolean? = false
    var data: Data? = null




    class Data : Serializable
    {
        // Getters and setters
        var version: String? = null
        var user: String? = null
        var dateGenerated: String? = null
        var status: String? = null
        var data: List<WeatherData>? = null
    }

    class WeatherData : Serializable
    {
        // Getters and setters
        var lat: Double? = 0.0
        var lon: Double? = 0.0
        var date: String? = null
        var parameters: List<Parameter>? = null
        var coordinates: List<Coordinates?>? = null
        var parameter: String? = null
    }

    class Parameter : Serializable
    {
        // Getters and setters
        var parameter: String? = null
        var value: Double? = 0.0

    }

     class Coordinates:Serializable
     {
         var lat: Double ?  = null
         val lon: Double?  = null
         val dates: List<DateValue> = emptyList()
     }


}



