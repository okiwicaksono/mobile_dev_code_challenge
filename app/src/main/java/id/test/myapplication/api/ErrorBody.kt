package id.test.myapplication.api

import com.squareup.moshi.Json
import com.squareup.moshi.Moshi
import id.test.myapplication.util.fromJson
import retrofit2.Response
import java.io.IOException

data class ErrorBody(val code: Int, @Json(name = "error") val message: String) {

    override fun toString(): String = "{code:$code, message:\"$message\"}"

    companion object {

        val UNKNOWN_ERROR = 0

        private val moshi = Moshi.Builder().build()

        fun parseError(response: Response<*>?): ErrorBody? {
            return (response?.errorBody())?.let {
                try {
                    moshi.fromJson(it.string())
                } catch (ignored: IOException) {
                    null
                }
            }
        }
    }

}