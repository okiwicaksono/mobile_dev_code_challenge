package com.anangsw.chatappschallenge.main.model

import android.os.Parcelable
import com.anangsw.chatappschallenge.utils.Constant
import kotlinx.parcelize.Parcelize

@Parcelize
data class MessagesUI(
    val attachment: String?,
    val body: String?,
    val from: String,
    val id: Int,
    val timestamp: String,
    val to: String,
    var images: List<MessagesUI>? = null,
    var documents: List<MessagesUI>? = null,
    var contacts: List<MessagesUI>? = null
): Parcelable {

    fun getMessageType(): String {
        if (images != null) {
            if (images!!.size == 2) {
                return Constant.FEED_TYPE_IMAGE2
            }
            if (images!!.size == 3) {
                return Constant.FEED_TYPE_IMAGE3
            }
            if (images!!.size > 3) {
                return Constant.FEED_TYPE_IMAGE4_OR_MORE
            }
        }
        if (documents != null) {
            return Constant.FEED_TYPE_DOCUMENT_MORE_THAN_ONE
        }
        if (contacts != null) {
            return Constant.FEED_TYPE_CONTACT_MORE_THAN_ONE
        }
        if (attachment != null) {
            return attachment
        }
        return Constant.FEED_TYPE_TEXT
    }

}