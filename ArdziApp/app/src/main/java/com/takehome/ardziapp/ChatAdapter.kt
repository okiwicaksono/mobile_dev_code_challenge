package com.takehome.ardziapp

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.takehome.ardziapp.model.Chat
import java.text.SimpleDateFormat
import java.util.*


class ChatAdapter(items: List<Chat>) :
    RecyclerView.Adapter<ChatAdapter.ViewHolder>() {

    private val mNewItems = ArrayList<Chat>()

    init {
        var i = 0
        var chat: Chat
        var feedType: Int?
        var images: List<Chat>
        var contacts: List<Chat>


        while (i < items.size) {
            chat = items[i]
            feedType = chat.feedType
            images = getImages(items, i)
            contacts = getContacts(items, i)
            if (feedType == Chat.FEED_IS_IMAGE && chat.body === null && images.isNotEmpty()) {
                chat.images.addAll(images)
                i += images.size
            } else if(feedType == Chat.FEED_IS_CONTACT && contacts.isNotEmpty()) {
                chat.contacts.addAll(contacts)
                i+= contacts.size
            } else {
                i++
            }
            mNewItems.add(chat)
        }
    }

    @SuppressLint("SimpleDateFormat")
    private fun createDate(timestamp: Long): String? {
        val timeD = Date(timestamp * 1000)
        val sdf = SimpleDateFormat("dd/MM/yyyy")
        return sdf.format(timeD)
    }

    private fun getImages(chatList: List<Chat>, offset: Int): List<Chat> {
        var i = offset + 1
        val sender = chatList[offset + 1].from
        val date = createDate(chatList[offset + 1].timestamp?.toLong() ?: 0)


        while (i < chatList.size && chatList[i].feedType == Chat.FEED_IS_IMAGE && chatList[i].from.equals(
                sender
            ) && createDate(chatList[i].timestamp?.toLong() ?: 0).equals(date)
        ) {
            i++
        }
        return if (i - offset < 4) emptyList() else chatList.subList(offset, i)
    }

    private fun getContacts(chatList:  List<Chat>, offset: Int): List<Chat> {
        var i = offset + 1
        val sender = chatList[offset + 1].from
        val date = createDate(chatList[offset + 1].timestamp?.toLong() ?: 0)


        while (i < chatList.size && chatList[i].feedType == Chat.FEED_IS_CONTACT && chatList[i].from.equals(
                sender
            ) && createDate(chatList[i].timestamp?.toLong() ?: 0).equals(date)
        ) {
            i++
        }
        return if (i - offset < 4) emptyList() else chatList.subList(offset, i)
    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val layoutId: Int = when (viewType) {
            Chat.FEED_IS_IMAGE -> R.layout.item_photo
            Chat.FEED_IS_ALBUM -> R.layout.item_photo_group
            Chat.FEED_IS_CONTACT -> R.layout.item_contact
            Chat.FEED_IS_GROUP_CONTACT -> R.layout.item_contact_group
            Chat.FEED_IS_DOCUMENT -> R.layout.item_document
            else -> R.layout.item_chat
        }
        val view =
            LayoutInflater.from(parent.context)
                .inflate(layoutId, parent, false)
        return ViewHolder(view, viewType)
    }

    @SuppressLint("SetTextI18n")
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = mNewItems[position]
        when (getItemViewType(position)) {
            Chat.FEED_IS_ALBUM -> {
                var i = 0
                while (i < 4) {
                    holder.photoALbums?.get(i)?.setImageResource(R.mipmap.ic_launcher)
                    i++
                }
                val plusImage = holder.photoALbums?.size?.minus(4) ?: 0
                if(plusImage > 0) {
                    holder.albumView4Overlay?.visibility = View.VISIBLE
                    holder.mAlbumImageCount?.visibility = View.VISIBLE
                    holder.mAlbumImageCount?.text = "+ ${((holder.photoALbums?.size?.minus(4)))}"
                } else {
                    holder.albumView4Overlay?.visibility = View.GONE
                    holder.mAlbumImageCount?.visibility = View.GONE
                }
            }
            Chat.FEED_IS_IMAGE -> holder.imagePhoto?.setImageResource(R.mipmap.ic_launcher)

            Chat.FEED_IS_GROUP_CONTACT -> {
                holder.tvContactGroup?.text = "More than one person"
            }

            Chat.FEED_IS_CONTACT -> {
                holder.tvChat?.text = "This is a person"
            }

            Chat.FEED_IS_DOCUMENT -> {
                holder.tvDocument?.text = "This is a document"
            }
            else -> holder.tvChat?.text = item.body
        }
    }

    override fun getItemViewType(position: Int): Int {
        return mNewItems[position].feedType
    }

    override fun getItemCount(): Int {
        return mNewItems.size
    }

    class ViewHolder(itemView: View, viewType: Int) :
        RecyclerView.ViewHolder(itemView) {
        var imagePhoto: ImageView? = null
        var tvChat: TextView? = null
        var tvDocument: TextView? = null
        var tvContact: TextView? = null
        var tvContactGroup: TextView? = null
        var photoALbums: MutableList<ImageView>? = null
        var mAlbumImageCount: TextView? = null
        var albumView4Overlay: View? = null

        init {
            when (viewType) {
                Chat.FEED_IS_DOCUMENT -> tvDocument = itemView.findViewById(R.id.tv_document)
                Chat.FEED_IS_IMAGE -> imagePhoto = itemView.findViewById(R.id.imageView)
                Chat.FEED_IS_ALBUM -> {
                    photoALbums = ArrayList()
                    photoALbums?.add(itemView.findViewById(R.id.albumView1))
                    photoALbums?.add(itemView.findViewById(R.id.albumView2))
                    photoALbums?.add(itemView.findViewById(R.id.albumView3))
                    photoALbums?.add(itemView.findViewById(R.id.albumView4))
                    mAlbumImageCount = itemView.findViewById(R.id.albumView4OverlayText)
                    albumView4Overlay = itemView.findViewById(R.id.albumView4Overlay)
                }
                Chat.FEED_IS_CONTACT -> tvContact = itemView.findViewById(R.id.tv_contact)
                Chat.FEED_IS_GROUP_CONTACT -> tvContactGroup =
                    itemView.findViewById(R.id.tv_contact_group)
                else -> tvChat = itemView.findViewById(R.id.tv_chat)
            }
        }
    }
}