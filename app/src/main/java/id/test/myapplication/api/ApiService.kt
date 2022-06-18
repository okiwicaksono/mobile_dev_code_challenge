package id.test.myapplication.api

import id.test.myapplication.model.DataResponse
import io.reactivex.Observable
import okhttp3.MultipartBody
import okhttp3.RequestBody
import retrofit2.http.*

interface ApiService {

///// GET
    @GET
    fun dataList(@Url url : String):Observable<DataResponse>




}