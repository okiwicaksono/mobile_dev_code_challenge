package com.anangsw.chatappschallenge.main.viewholder

import android.view.View
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import com.anangsw.chatappschallenge.databinding.ItemThreeImageMessageBinding
import com.anangsw.chatappschallenge.databinding.ItemTwoImageMessageBinding
import com.anangsw.chatappschallenge.main.model.MessagesUI
import com.anangsw.chatappschallenge.utils.Constant

class ThreeImageViewHolder(private val viewBinding: ItemThreeImageMessageBinding) :
    RecyclerView.ViewHolder(viewBinding.root) {

    fun onBind(messagesUI: MessagesUI) {
        viewBinding.message = messagesUI
        // Asumming current user is A
        if (messagesUI.from == Constant.CURRENT_USER) {
            viewBinding.ivIncomingAvatar.isVisible = false
            viewBinding.ivImageIncoming.twoImageContainer.visibility = View.INVISIBLE
        } else {
            viewBinding.ivOutgoingAvatar.isVisible = false
            viewBinding.ivImageOutgoing.twoImageContainer.visibility = View.INVISIBLE

        }
    }

}