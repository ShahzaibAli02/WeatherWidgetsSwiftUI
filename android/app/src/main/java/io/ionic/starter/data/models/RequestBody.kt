package io.ionic.starter.data.models

class RequestBody
{
    // Getters and setters
    var parameters: List<String>? = null
    var location: List<String>? = null
    var date: String? = null

    var startdate: String ?  = null
    var enddate: String ?  = null
    var resolution: String ?  = null
    var coordinate: String ?  = null
    var model: String = "mix"
    var format: String = "json"
    var lang: String = "en"
}
