package io.ionic.starter.data.models

import java.io.Serializable

data class Weather(
    var currentTemperature: String? = null,
    var currentFeelLikeTemp: String? = null,
    var windSpeed: String? = null,
    var _24hHighTemp: String? = null,
    var _24LowTemp: String? = null,
    var _24WindSpeed: String? = null,
    var _24WindDirection: String? = null,
    var _24Precip: String? = null,
    var _24PrecipProb: String? = null,
    var weatherSymbol : Int = 0,
    var _6hoursForeCastTemp : List<DateValue>? = emptyList(),
    var _6hoursForeCastIcons : List<DateValue>? = emptyList(),

    var _5DaysForeCastIcons : List<DateValue>? = emptyList(),
    var _5DaysForeCastHighTemp : List<DateValue>? = emptyList(),
    var _5DaysForeCastLowTemp : List<DateValue>? = emptyList(),

    ):Serializable
