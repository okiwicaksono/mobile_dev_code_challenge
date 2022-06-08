package com.anangsw.chatappschallenge.main.viewholder

import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import com.anangsw.chatappschallenge.R
import com.anangsw.chatappschallenge.databinding.ItemTextMessageBinding
import com.anangsw.chatappschallenge.main.model.MessagesUI
import com.anangsw.chatappschallenge.utils.Constant

class TextViewHolder(private val viewBinding: ItemTextMessageBinding) :
    RecyclerView.ViewHolder(viewBinding.root) {

    fun onBind(messagesUI: MessagesUI, lastMessageFrom: String?) {
        viewBinding.message = messagesUI
        // Asumming current user is A
        if (messagesUI.from == Constant.CURRENT_USER) {
            viewBinding.viewPaddingEnd.visibility = View.GONE
            viewBinding.ivIncomingAvatar.isVisible = false
            viewBinding.ivOutgoingAvatar.isVisible = messagesUI.from != lastMessageFrom
            if (messagesUI.from == lastMessageFrom) {
                viewBinding.tvMsg.background = ContextCompat.getDrawable(
                    itemView.context, R.drawable.bg_outgoing_buble_rounded
                )
            } else {
                viewBinding.tvMsg.background = ContextCompat.getDrawable(
                    itemView.context, R.drawable.bg_outgoing_buble
                )
            }
        } else {
            viewBinding.viewPaddingStart.visibility = View.GONE
            viewBinding.ivOutgoingAvatar.isVisible = false
            viewBinding.ivIncomingAvatar.isVisible = messagesUI.from != lastMessageFrom
            if (messagesUI.from == lastMessageFrom) {
                viewBinding.tvMsg.background = ContextCompat.getDrawable(
                    itemView.context, R.drawable.bg_incoming_buble_rounded
                )
            } else {
                viewBinding.tvMsg.background = ContextCompat.getDrawable(
                    itemView.context, R.drawable.bg_incoming_buble
                )
            }
        }
    }

}