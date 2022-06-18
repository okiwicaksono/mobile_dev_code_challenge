package id.test.myapplication.model


import com.google.gson.annotations.SerializedName

data class DataResponse(
    @SerializedName("data")
    val `data`: List<Data?>?
) {
    data class Data(
        @SerializedName("attachment")
        val attachment: String,
        @SerializedName("body")
        val body: String,
        @SerializedName("from")
        val from: String?,
        @SerializedName("id")
        val id: Int?,
        @SerializedName("timestamp")
        val timestamp: String?,
        @SerializedName("to")
        val to: String?
    )
}