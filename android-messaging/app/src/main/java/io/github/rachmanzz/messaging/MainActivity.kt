package io.github.rachmanzz.messaging

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.format.DateFormat
import io.github.rachmanzz.messaging.databinding.ActivityMainBinding
import io.github.rachmanzz.messaging.utils.MessageCollection
import io.github.rachmanzz.messaging.utils.MessageItemOutput
import io.github.rachmanzz.messaging.utils.MessagingAsset
import java.util.*

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
    }


    private fun collectingMessages() {
        val messageAsset = MessagingAsset(this, "messagedataset.json")

        messageAsset.getMessageList()?.apply {
            // sorting message ascending by timestamp
            val messageAssetItem = this.sortedBy { it.timestamp }

            // collecting message that has been sorted and group
            val finalResultMessage = arrayListOf<MessageCollection>()

            // cache message item before pushing to finalResultMessage
            val cacheMessages = arrayListOf<MessageCollection>()

            // wrapping try catch to make sure and throw the timestamp if invalid
            try {

                for (item in messageAssetItem) {
                    val lastItem = finalResultMessage.last()
                    val lastItemBody: String? = lastItem.collection.last().body

                    val timestamp: Long = item.timestamp.toLong() * 1000
                    val messageDate = Date(timestamp)
                    // convert timestamp to date dd-MM-yyyy
                    val stringDate = DateFormat.format("dd-MM-yyyy", messageDate).toString()

                    val outputItem = MessageItemOutput(
                        id = item.id,
                        body = item.body,
                        timestamp = item.timestamp
                    )
                    val collectingMessage = MessageCollection(
                        txtDate = stringDate,
                        attachment = item.attachment,
                        from = item.from,
                        to = item.to,
                        collection = arrayListOf(outputItem)
                    )

                    // attachment not null, not document, attachment is same with last item, date is same with last item, body is null, and sender message same with last item
                    if (item.attachment != null && item.attachment != "document" && lastItem.attachment == item.attachment && lastItem.txtDate == stringDate && lastItemBody == null && lastItem.from == item.from) {
                        // cache the item
                        cacheMessages.add(collectingMessage)
                    } else {
                        val cacheSize = cacheMessages.size
                        // review cache if not empty
                        if (cacheSize >= 1) {
                            val cacheAttachment = cacheMessages.last().attachment

                            // check cacheAttachment is image & size same or more then 4 item
                            // or attachment is contact & size same or more then 2 item
                            if (cacheAttachment == "image" && cacheSize >= 4 || cacheAttachment == "contact" && cacheSize >= 2) {
                                val itemCollected = cacheMessages.map {
                                    // get first or last item is always same, because each item only store 1 collection
                                    it.collection.first()
                                }
                                // push caches message to last item of finalResultMessage collection that has mapping
                                finalResultMessage.last().collection.addAll(itemCollected)
                            } else {
                                // because the cache does not meet the criteria, push all message to last of finalResultMessage
                                finalResultMessage.addAll(cacheMessages)
                            }
                            // clear all cache message
                            cacheMessages.clear()
                        }

                        finalResultMessage.add(collectingMessage)
                    }
                }

            } catch (e: java.lang.Exception) {e.printStackTrace()}
        }
    }
}