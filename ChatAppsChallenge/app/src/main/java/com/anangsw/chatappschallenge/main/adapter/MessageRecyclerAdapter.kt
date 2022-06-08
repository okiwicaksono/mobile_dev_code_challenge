package com.anangsw.chatappschallenge.main.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.RecyclerView
import com.anangsw.chatappschallenge.R
import com.anangsw.chatappschallenge.main.model.MessagesUI
import com.anangsw.chatappschallenge.main.viewholder.*
import com.anangsw.chatappschallenge.utils.Constant

class MessageRecyclerAdapter : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private val messages = mutableListOf<MessagesUI>()

    @SuppressLint("NotifyDataSetChanged")
    fun submitList(messages: List<MessagesUI>) {
        this.messages.clear()
        this.messages.addAll(messages)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when (messages[viewType].getMessageType()) {
            Constant.FEED_TYPE_IMAGE -> {
                ImageViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context),
                        R.layout.item_image_message,
                        parent,
                        false
                    )
                )
            }
            Constant.FEED_TYPE_IMAGE2 -> {
                TwoImageViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context),
                        R.layout.item_two_image_message,
                        parent,
                        false
                    )
                )
            }
            Constant.FEED_TYPE_IMAGE3 -> {
                ThreeImageViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context),
                        R.layout.item_three_image_message,
                        parent,
                        false
                    )
                )
            }
            Constant.FEED_TYPE_IMAGE4_OR_MORE -> {
                FourOrMoreImageViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context),
                        R.layout.item_fourormore_image_message,
                        parent,
                        false
                    )
                )
            }
            Constant.FEED_TYPE_CONTACT -> {
                ContactViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context),
                        R.layout.item_contact_message,
                        parent,
                        false
                    )
                )
            }
            Constant.FEED_TYPE_CONTACT_MORE_THAN_ONE -> {
                ContactViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context),
                        R.layout.item_contact_message,
                        parent,
                        false
                    )
                )
            }
            Constant.FEED_TYPE_DOCUMENT -> {
                DocumentViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context),
                        R.layout.item_document_message,
                        parent,
                        false
                    )
                )
            }
            Constant.FEED_TYPE_DOCUMENT_MORE_THAN_ONE -> {
                DocumentViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context),
                        R.layout.item_document_message,
                        parent,
                        false
                    )
                )
            }
            else -> {
                TextViewHolder(
                    DataBindingUtil.inflate(
                        LayoutInflater.from(parent.context),
                        R.layout.item_text_message,
                        parent,
                        false
                    )
                )
            }
        }
    }

    override fun getItemViewType(position: Int): Int {
        return position
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        val lastMessageFrom = if (position != 0) {
            messages[position - 1].from
        } else {
            null
        }
        return when (messages[position].getMessageType()) {
            Constant.FEED_TYPE_IMAGE -> {
                (holder as ImageViewHolder).onBind(messages[position])
            }
            Constant.FEED_TYPE_IMAGE2 -> {
                (holder as TwoImageViewHolder).onBind(messages[position])
            }
            Constant.FEED_TYPE_IMAGE3 -> {
                (holder as ThreeImageViewHolder).onBind(messages[position])
            }
            Constant.FEED_TYPE_IMAGE4_OR_MORE -> {
                (holder as FourOrMoreImageViewHolder).onBind(messages[position])
            }
            Constant.FEED_TYPE_CONTACT -> {
                (holder as ContactViewHolder).onBind(messages[position])
            }
            Constant.FEED_TYPE_CONTACT_MORE_THAN_ONE -> {
                (holder as ContactViewHolder).onBind(messages[position])
            }
            Constant.FEED_TYPE_DOCUMENT -> {
                (holder as DocumentViewHolder).onBind(messages[position])
            }
            Constant.FEED_TYPE_DOCUMENT_MORE_THAN_ONE -> {
                (holder as DocumentViewHolder).onBind(messages[position])
            }
            else -> {
                (holder as TextViewHolder).onBind(messages[position], lastMessageFrom)
            }
        }
    }

    override fun getItemCount(): Int {
        return messages.size
    }
}