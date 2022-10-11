package io.github.rachmanzz.messaging.utils

data class MessageItemOutput(
    val id: Int,
    val body: String?,
    val timestamp: String
)
data class MessageCollection(
    val txtDate: String,
    val attachment: String?,
    val from: Char,
    val to: Char,
    var collection: ArrayList<MessageItemOutput>
)
