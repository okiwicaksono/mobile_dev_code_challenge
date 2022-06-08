package com.anangsw.chatappschallenge.main.viewholder

import android.view.View
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import com.anangsw.chatappschallenge.databinding.ItemFourormoreImageMessageBinding
import com.anangsw.chatappschallenge.main.model.MessagesUI
import com.anangsw.chatappschallenge.utils.Constant

class FourOrMoreImageViewHolder(private val viewBinding: ItemFourormoreImageMessageBinding) :
    RecyclerView.ViewHolder(viewBinding.root) {

    fun onBind(messagesUI: MessagesUI) {
        viewBinding.message = messagesUI
        val moreImage = messagesUI.images?.size?.minus(4)
        // Asumming current user is A
        if (messagesUI.from == Constant.CURRENT_USER) {
            viewBinding.ivIncomingAvatar.isVisible = false
            viewBinding.ivImageIncoming.twoImageContainer.visibility = View.INVISIBLE
            viewBinding.ivImageOutgoing.tvMore.text = "+$moreImage more"
            viewBinding.ivImageOutgoing.tvMore.isVisible =
                moreImage != null && moreImage > 0
        } else {
            viewBinding.ivOutgoingAvatar.isVisible = false
            viewBinding.ivImageOutgoing.twoImageContainer.visibility = View.INVISIBLE
            viewBinding.ivImageIncoming.tvMore.text = "+$moreImage more"
            viewBinding.ivImageIncoming.tvMore.isVisible =
                moreImage != null && moreImage > 0
        }
    }

}