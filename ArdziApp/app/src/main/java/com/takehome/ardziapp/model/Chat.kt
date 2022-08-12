package com.takehome.ardziapp.model

class Chat {
     val attachment: String? = null
     val body: String? = null
     val from: String? = null
     val id: Int? = 0
     val timestamp: String? = null
     val to: String? = null
     var images = ArrayList<Chat>()
     var contacts = ArrayList<Chat>()


     val feedType: Int
         get() {
             if (attachment.equals("contact") && contacts.size == 0) {
                 return FEED_IS_CONTACT
             } else if (attachment.equals("contact") && contacts.size > 0) {
                 return FEED_IS_GROUP_CONTACT
             } else if (attachment.equals("document")) {
                 return FEED_IS_DOCUMENT
             } else if (attachment.equals("image") && images.size == 0) {
                 return  FEED_IS_IMAGE
             } else if (attachment.equals("image") && images.size > 0) {
                 return FEED_IS_ALBUM
             } else {
                 return  FEED_IS_CHAT
             }
         }

     companion object {
         const val FEED_IS_CHAT = 1
         const val FEED_IS_CONTACT = 2
         const val FEED_IS_GROUP_CONTACT = 3
         const val FEED_IS_IMAGE = 4
         const val FEED_IS_ALBUM = 5
         const val FEED_IS_DOCUMENT= 6

     }
 }