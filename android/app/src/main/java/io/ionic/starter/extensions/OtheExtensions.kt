package io.ionic.starter.extensions

import kotlin.math.roundToInt

fun String.roundStringValue(): String {
    return try {
        val number = this.toDouble()
        val rounded = number.roundToInt()
        rounded.toString()
    } catch (e: NumberFormatException) {
        ""
    }
}