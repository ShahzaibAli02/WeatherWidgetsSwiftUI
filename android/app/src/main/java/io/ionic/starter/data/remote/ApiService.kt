package io.ionic.starter.data.remote;

import io.ionic.starter.data.models.ApiResponse;
import io.ionic.starter.data.models.RequestBody;
import retrofit2.Call;
import retrofit2.Response
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.POST;

interface ApiService {
    @POST("api/ncm/device/route-query")
    suspend fun routeQuery(
        @Header("Authorization") authorization: String,
        @Body requestBody: RequestBody
    ): ApiResponse


    @POST("api/ncm/device/public-query")
    suspend fun publicQuery(
        @Header("Authorization") authorization: String,
        @Body requestBody: RequestBody
    ): ApiResponse
}