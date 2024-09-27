package io.ionic.starter.data.models

import androidx.annotation.DrawableRes
import androidx.annotation.StringRes

data class WeatherSymbol(@StringRes val description:Int,@DrawableRes val icon:Int)