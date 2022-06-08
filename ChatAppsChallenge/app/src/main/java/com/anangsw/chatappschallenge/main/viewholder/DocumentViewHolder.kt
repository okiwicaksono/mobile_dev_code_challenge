package com.anangsw.chatappschallenge.main.viewholder

import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import com.anangsw.chatappschallenge.R
import com.anangsw.chatappschallenge.databinding.ItemDocumentMessageBinding
import com.anangsw.chatappschallenge.main.model.MessagesUI
import com.anangsw.chatappschallenge.utils.Constant

class DocumentViewHolder(private val viewBinding: ItemDocumentMessageBinding) :
    RecyclerView.ViewHolder(viewBinding.root) {

    fun onBind(messagesUI: MessagesUI) {
        viewBinding.message = messagesUI
        // Asumming current user is A
        if (messagesUI.from == Constant.CURRENT_USER) {
            viewBinding.ivIncomingAvatar.isVisible = false
            viewBinding.documentOutgoing.docsContainer.background =
                ContextCompat.getDrawable(itemView.context, R.drawable.bg_rounded_blue)
            viewBinding.documentIncoming.docsContainer.visibility = View.INVISIBLE

            if (messagesUI.documents == null) {
                viewBinding.documentOutgoing.tvDocsText.text = "This is a document"
            } else {
                viewBinding.documentOutgoing.ivDocs.setImageDrawable(
                    ContextCompat.getDrawable(
                        itemView.context,
                        R.drawable.ic_baseline_files
                    )
                )
                viewBinding.documentOutgoing.tvDocsText.text =
                    "There is ${messagesUI.documents!!.size} documents"
            }
        } else {
            viewBinding.ivOutgoingAvatar.isVisible = false
            viewBinding.documentOutgoing.docsContainer.visibility = View.INVISIBLE
            if (messagesUI.contacts == null) {
                viewBinding.documentIncoming.tvDocsText.text = "This is a contact"
            } else {
                viewBinding.documentIncoming.ivDocs.setImageDrawable(
                    ContextCompat.getDrawable(
                        itemView.context,
                        R.drawable.ic_baseline_files
                    )
                )
                viewBinding.documentIncoming.tvDocsText.text =
                    "There is ${messagesUI.documents!!.size} documents"
            }
        }
    }

}