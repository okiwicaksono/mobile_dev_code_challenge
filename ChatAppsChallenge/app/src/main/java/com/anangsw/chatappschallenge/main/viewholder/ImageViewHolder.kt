package com.anangsw.chatappschallenge.main.viewholder

import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import com.anangsw.chatappschallenge.R
import com.anangsw.chatappschallenge.databinding.ItemImageMessageBinding
import com.anangsw.chatappschallenge.main.model.MessagesUI
import com.anangsw.chatappschallenge.utils.Constant

class ImageViewHolder(private val viewBinding: ItemImageMessageBinding) :
    RecyclerView.ViewHolder(viewBinding.root) {

    fun onBind(messagesUI: MessagesUI) {
        viewBinding.message = messagesUI
        viewBinding.tvMsg.visibility = if (messagesUI.body != null) View.VISIBLE else View.GONE
        // Asumming current user is A
        if (messagesUI.from == Constant.CURRENT_USER) {
            viewBinding.ivIncomingAvatar.isVisible = false
            viewBinding.ivImageIncoming.visibility = View.INVISIBLE
            viewBinding.viewPaddingEnd.visibility = View.GONE
            viewBinding.tvMsg.background = ContextCompat.getDrawable(
                itemView.context, R.drawable.bg_outgoing_buble_rounded
            )
        } else {
            viewBinding.ivOutgoingAvatar.isVisible = false
            viewBinding.ivImageOutgoing.visibility = View.INVISIBLE
            viewBinding.viewPaddingStart.visibility = View.GONE
            viewBinding.tvMsg.background = ContextCompat.getDrawable(
                itemView.context, R.drawable.bg_incoming_buble_rounded
            )

        }
    }

}