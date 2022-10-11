package io.github.rachmanzz.messaging.utils

import android.content.Context
import android.util.Log
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import java.io.IOException

data class MessageItem(
    val id: Int,
    val body: String? = null,
    val attachment: String? = null,
    val timestamp: String,
    val from: Char,
    val to: Char
)

data class MessageWrapper(
    val data: List<MessageItem>
)

class MessagingAsset(context: Context, resource: String) {
    private var rawJsonString: String? = null

    init {
        try {
            rawJsonString = context.assets.open(resource).bufferedReader().use{ it.readText() }
        } catch (e: IOException) {
            e.printStackTrace()
            Log.i("unable", "unable read the doc")
        }
    }

    fun getMessageList (): List<MessageItem>? {
        val gson = Gson()
        val type = object : TypeToken<MessageWrapper>(){}.type

        val wrapper: MessageWrapper? = rawJsonString.let {
            gson.fromJson(it, type)
        }
        return wrapper?.data
    }
}