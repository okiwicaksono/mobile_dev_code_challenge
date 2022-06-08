package com.anangsw.chatappschallenge.main.viewholder

import android.view.View
import androidx.core.content.ContextCompat
import androidx.core.view.isVisible
import androidx.recyclerview.widget.RecyclerView
import com.anangsw.chatappschallenge.R
import com.anangsw.chatappschallenge.databinding.ItemContactMessageBinding
import com.anangsw.chatappschallenge.main.model.MessagesUI
import com.anangsw.chatappschallenge.utils.Constant

class ContactViewHolder(private val viewBinding: ItemContactMessageBinding) :
    RecyclerView.ViewHolder(viewBinding.root) {

    fun onBind(messagesUI: MessagesUI) {
        viewBinding.message = messagesUI
        // Asumming current user is A
        if (messagesUI.from == Constant.CURRENT_USER) {
            viewBinding.contactOutgoing.contactContainer.background =
                ContextCompat.getDrawable(itemView.context, R.drawable.bg_rounded_blue)
            viewBinding.ivIncomingAvatar.isVisible = false
            viewBinding.contactIncoming.contactContainer.visibility = View.INVISIBLE

            if (messagesUI.contacts == null) {
                viewBinding.contactOutgoing.tvContactText.text = "This is a contact"
            } else {
                viewBinding.contactOutgoing.ivContact.setImageDrawable(
                    ContextCompat.getDrawable(
                        itemView.context,
                        R.drawable.ic_baseline_contacts_24
                    )
                )
                viewBinding.contactOutgoing.tvContactText.text = "There is ${messagesUI.contacts!!.size} contacts"
            }
        } else {
            viewBinding.ivOutgoingAvatar.isVisible = false
            viewBinding.contactOutgoing.contactContainer.visibility = View.INVISIBLE
            if (messagesUI.contacts == null) {
                viewBinding.contactIncoming.tvContactText.text = "This is a contact"
            } else {
                viewBinding.contactIncoming.ivContact.setImageDrawable(
                    ContextCompat.getDrawable(
                        itemView.context,
                        R.drawable.ic_baseline_contacts_24
                    )
                )
                viewBinding.contactIncoming.tvContactText.text = "There is ${messagesUI.contacts!!.size} contacts"
            }
        }
    }

}