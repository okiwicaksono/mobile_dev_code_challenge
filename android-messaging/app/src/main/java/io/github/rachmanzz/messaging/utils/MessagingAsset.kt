package io.github.rachmanzz.messaging.utils

import android.content.Context
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
        } catch (e: IOException) {e.printStackTrace()}
    }

}