package io.ionic.starter.data.models

import androidx.annotation.DrawableRes
import io.ionic.starter.R

class Result<T>
{
    @JvmField
    var errorCode: Int = -1

    @DrawableRes
    @JvmField
    var errorIcon: Int = R.drawable.ic_error
    @JvmField
    var message: String = ""
    @JvmField
    var description: String = ""
    @JvmField
    var data: T ? = null

    constructor(errorCode: Int, message: String, data: T)
    {
        this.errorCode = errorCode
        this.message = message
        this.data = data
    }


    constructor(errorCode: Int,errorIcon: Int, message: String,description: String)
    {
        this.errorCode = errorCode
        this.errorIcon = errorIcon
        this.message = message
        this.description = description
    }

    constructor(data: T)
    {
        this.data = data
    }
}
