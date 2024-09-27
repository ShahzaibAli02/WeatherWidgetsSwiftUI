package io.ionic.starter.data.remote;

import io.ionic.starter.BuildConfig
import retrofit2.Retrofit;
import retrofit2.converter.moshi.MoshiConverterFactory

object RetrofitFactory {


    fun makeRetrofitService(): ApiService
    {
        return Retrofit.Builder()
            .baseUrl(BuildConfig.BASE_URL)
            .addConverterFactory(MoshiConverterFactory.create())
            .build().create(ApiService::class.java)
    }
}
