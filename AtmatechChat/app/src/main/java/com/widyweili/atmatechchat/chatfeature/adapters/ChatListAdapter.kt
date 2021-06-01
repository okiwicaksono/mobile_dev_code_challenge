package com.widyweili.atmatechchat.chatfeature.adapters

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.core.util.Predicate
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.widyweili.atmatechchat.MainActivity
import com.widyweili.atmatechchat.chatfeature.m.Chat
import com.widyweili.atmatechchat.chatfeature.v.ChatFragment
import com.widyweili.atmatechchat.databinding.*
import com.widyweili.atmatechchat.utilities.searchByTag
import com.widyweili.atmatechchat.R
import com.widyweili.atmatechchat.chatfeature.vm.ChatViewModel
import java.lang.Exception
import java.text.SimpleDateFormat
import java.util.*

class ChatListAdapter(private val viewModel: ChatViewModel) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    var currentUser = "A"
    private lateinit var fragInstance: ChatFragment
    private val hourMinFmt = SimpleDateFormat("HH:mm", Locale.getDefault())
    private val dateFmt = SimpleDateFormat("dd MMMM yyyy", Locale.getDefault())
    private val sdf = SimpleDateFormat("dd/MM/yyyy", Locale.getDefault())
    private val templateContactStrs = arrayOf("Tinky", "Winky", "Dipsy", "Lala", "Po")
    private val templateDocStrs = arrayOf("Nightcore - Light It Up","Nightcore - Dreams", "Nightcore - Wellerman Sea Shanty", "Nightcore - The Phoenix", "Nightcore - Pompeii")
    private val generatedContacts = mutableListOf<String>()
    private val generatedDocuments = mutableListOf<String>()
    private var isDatesCalculated: Boolean = false
    private var chats = emptyList<Chat>()

    inner class MsgLeftChatViewHolder(val binding: CardviewChatLeftBinding) : RecyclerView.ViewHolder(binding.root) {}
    inner class MsgRightChatViewHolder(val binding: CardviewChatRightBinding) : RecyclerView.ViewHolder(binding.root) {}
    inner class ImageLeftChatViewHolder(val binding: CardviewChatLeftImageBinding) : RecyclerView.ViewHolder(binding.root) {}
    inner class ImageRightChatViewHolder(val binding: CardviewChatRightImageBinding) : RecyclerView.ViewHolder(binding.root) {}
    inner class ContactLeftChatViewHolder(val binding: CardviewChatLeftContactBinding) : RecyclerView.ViewHolder(binding.root) {}
    inner class ContactRightChatViewHolder(val binding: CardviewChatRightContactBinding) : RecyclerView.ViewHolder(binding.root) {}
    inner class DocumentLeftChatViewHolder(val binding: CardviewChatLeftDocumentBinding) : RecyclerView.ViewHolder(binding.root) {}
    inner class DocumentRightChatViewHolder(val binding: CardviewChatRightDocumentBinding) : RecyclerView.ViewHolder(binding.root) {}

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return when(viewType){
            0-> {
                val v = CardviewChatRightBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                MsgRightChatViewHolder(v)
            }
            1->{
                val v = CardviewChatLeftBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                MsgLeftChatViewHolder(v)
            }
            2->{
                val v = CardviewChatRightImageBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                ImageRightChatViewHolder(v)
            }
            3->{
                val v = CardviewChatLeftImageBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                ImageLeftChatViewHolder(v)
            }
            4->{
                val v = CardviewChatRightContactBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                ContactRightChatViewHolder(v)
            }
            5->{
                val v = CardviewChatLeftContactBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                ContactLeftChatViewHolder(v)
            }
            6->{
                val v = CardviewChatRightDocumentBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                DocumentRightChatViewHolder(v)
            }
            else->{
                val v = CardviewChatLeftDocumentBinding.inflate(LayoutInflater.from(parent.context), parent, false)
                DocumentLeftChatViewHolder(v)
            }
        }
    }

    override fun getItemCount(): Int {
        return chats.size
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        val currentChat = chats[position]
        // follow up filter feature
        when(holder){
            // kelemahan dari viewBinding
            is MsgRightChatViewHolder->{
                checkBodyMsg(holder.binding.messageChat,position)
                validateEachMsgDate(holder.binding.dateView,holder.binding.timeChat,position)
            }
            is MsgLeftChatViewHolder->{
                checkBodyMsg(holder.binding.messageChat,position)
                validateEachMsgDate(holder.binding.dateView,holder.binding.timeChat,position)
            }
            is ImageRightChatViewHolder->{
                if(currentChat.resources==null){
                    holder.binding.photoContainer.groupPhotoOne.background = ContextCompat.getDrawable(fragInstance.requireContext(),R.color.colorAccent)
                }
                checkBodyMsg(holder.binding.messageChat,position)
                validateEachMsgDate(holder.binding.dateView,holder.binding.timeChat,position)
            }
            is ImageLeftChatViewHolder->{
                if(currentChat.resources==null){
                    holder.binding.photoContainer.groupPhotoOne.background = ContextCompat.getDrawable(fragInstance.requireContext(),R.color.colorAccent)
                }
                checkBodyMsg(holder.binding.messageChat,position)
                validateEachMsgDate(holder.binding.dateView,holder.binding.timeChat,position)
            }
            is ContactRightChatViewHolder->{
                checkBodyMsg(holder,position)
                validateEachMsgDate(holder.binding.dateView,holder.binding.timeChat,position)
            }
            is ContactLeftChatViewHolder->{
                checkBodyMsg(holder,position)
                validateEachMsgDate(holder.binding.dateView,holder.binding.timeChat,position)
            }
            is DocumentRightChatViewHolder->{
                checkBodyMsg(holder,position)
                validateEachMsgDate(holder.binding.dateView,holder.binding.timeChat,position)
            }
            is DocumentLeftChatViewHolder->{
                checkBodyMsg(holder,position)
                validateEachMsgDate(holder.binding.dateView,holder.binding.timeChat,position)
            }
        }
    }

    // prevent function for view that's getting recycled
    private fun checkBodyMsg(tv: TextView, pos: Int){
        val currentChat = chats[pos]
        if(currentChat.body!= null){
            tv.text = currentChat.body
            tv.visibility = View.VISIBLE
            return
        }
        tv.visibility = View.GONE
    }

    // bad, bad, bad, bad overriding because of inflexible viewBinding
    private fun checkBodyMsg(crcvh: ContactRightChatViewHolder, pos: Int){
        val currentChat = chats[pos]
        val tv = crcvh.binding.messageChat
        tv.visibility = View.VISIBLE
        if(currentChat.body!= null){
            tv.text = currentChat.body
            return
        }
        tv.text=generatedContacts[pos]
    }

    private fun checkBodyMsg(clcvh: ContactLeftChatViewHolder, pos: Int){
        val currentChat = chats[pos]
        val tv = clcvh.binding.messageChat
        tv.visibility = View.VISIBLE
        if(currentChat.body!= null){
            tv.text = currentChat.body
            return
        }
        tv.text=generatedContacts[pos]
    }

    private fun checkBodyMsg(drcvh: DocumentRightChatViewHolder, pos: Int){
        val currentChat = chats[pos]
        val tv = drcvh.binding.messageChat
        tv.visibility = View.VISIBLE
        if(currentChat.body!= null){
            tv.text = currentChat.body
            return
        }
        tv.text=generatedDocuments[pos]
    }

    private fun checkBodyMsg(dlcvh: DocumentLeftChatViewHolder, pos: Int){
        val currentChat = chats[pos]
        val tv = dlcvh.binding.messageChat
        tv.visibility = View.VISIBLE
        if(currentChat.body!= null){
            tv.text = currentChat.body
            return
        }
        tv.text=generatedDocuments[pos]
    }

    private fun validateEachMsgDate(tvDate: TextView, tvHour: TextView, pos: Int){
        val currentChat = chats[pos]
        tvHour.text = hourMinFmt.format(currentChat.timestamp)
        if(currentChat.isFirstDay){
            tvDate.text = dateFmt.format(currentChat.timestamp)
            tvDate.visibility = View.VISIBLE
            return
        }
        tvDate.visibility = View.GONE
    }

    override fun onAttachedToRecyclerView(recyclerView: RecyclerView) {
        super.onAttachedToRecyclerView(recyclerView)
        val act = recyclerView.context as MainActivity
        fragInstance = act.supportFragmentManager.fragments.searchByTag("ChatFragment") as ChatFragment
    }

    // 0 -> same user and is a message
    // 1 -> other user and is a message
    // 2 -> same user and is an image
    // 3 -> other user and is an image
    // 4 -> same user and is a contact
    // 5 -> other user and is a contact
    // 6 -> same user and is a document
    // 7 -> other user and is a document
    override fun getItemViewType(position: Int): Int {
        val otherUser = chats[position].from
        val msgType = chats[position].attachment
        return if(currentUser == otherUser && msgType==null) 0
        else if(currentUser != otherUser && msgType==null) 1
        else if(currentUser == otherUser && msgType=="image") 2
        else if(currentUser != otherUser && msgType=="image") 3
        else if(currentUser == otherUser && msgType=="contact") 4
        else if(currentUser != otherUser && msgType=="contact") 5
        else if(currentUser == otherUser && msgType=="document") 6
        else 7
    }

    // also bad codes, imagine if you have 100K messages, this function may work, but will pausing ui main thread
    // what happen if you need to pull data from server?it's even worse
    // other solution maybe use background thread and split messages from xIdx to yIdx
    // right now, solution may work because data is still small
    fun recalculateDates(){
        var (oldestDay,oldestMonth,oldestYear) = getDateDetails(chats[0].timestamp)
        var checkFirstDatePointer = 0
        for(i in 1 until chats.count()){
            val (oldDay,oldMonth,oldYear) = getDateDetails(chats[i].timestamp)
            val diffDays = oldDay-oldestDay
            val diffMonth = oldMonth-oldestMonth
            val diffYear = oldYear-oldestYear
            if(diffDays>=1 || diffMonth>=1 || diffYear>=1){
                chats[checkFirstDatePointer].isFirstDay = true
                chats[i].isFirstDay = true
                checkFirstDatePointer = i
            }
            oldestDay = if(diffDays>=1)oldDay else oldestDay
            oldestMonth = if(diffMonth>=1)oldMonth else oldestMonth
            oldestYear = if(diffYear>=1)oldYear else oldestYear
        }
        isDatesCalculated = true
    }

    // needs to run recalculateDates first
    fun checkYesterday(){
        if(!isDatesCalculated) throw Exception("You need to call recalculateDates() function first, then call this function: checkYesterday()")

        var yesterdayIndex = -1
        for(i in chats.count()-1 until 0){
            if(chats[i].isFirstDay){
                yesterdayIndex = i
                break
            }
        }
        if(yesterdayIndex != -1){
            val currentDate = Calendar.getInstance().time
            val date = sdf.format(chats[yesterdayIndex].timestamp)
            val currentDateStr = sdf.format(currentDate)
            val yesterday = date.substring(0,2).toInt()
            val today = currentDateStr.substring(0,2).toInt()
            val diffDay = today - yesterday
            if(diffDay==1) chats[yesterdayIndex].isYesterday = true
        }
    }

    private fun getDateDetails(dateRef: Date) : Triple<Int,Int,Int>{
        val date = sdf.format(dateRef)
        val day = date.substring(0,2).toInt()
        val month = date.substring(3,5).toInt()
        val year = date.substring(6,date.length).toInt()
        return Triple(day,month,year)
    }

    fun generateRandomData(){
        for(i in 0 until chats.count()){
            var selectedIdx = (0 until templateContactStrs.count()).random()
            generatedContacts.add(templateContactStrs[selectedIdx])
            selectedIdx = (0 until  templateDocStrs.count()).random()
            generatedDocuments.add(templateDocStrs[selectedIdx])
        }
    }

    fun changeDataBasedOnFilter(){
        val filterList = viewModel.getFilters()
        val predicates:MutableList<((t: Chat) -> Boolean?)?> = mutableListOf()
        filterList.forEach { if(it.flag && it.filterType=="internal") predicates.add(it.predicate) }
        val externalFilters = filterList.filter { it.filterType!="internal" && it.flag }
        var filteredChat = viewModel.getChats().filter { candidate -> predicates.all {
            it?.invoke(candidate)?:false
        } }

        if(externalFilters.count()>0){
            val limitedList= mutableListOf<Chat>()
            externalFilters.forEach { outerIt ->
                val num = outerIt.filterTitle.filter { Character.isDigit(it) }.toInt()
                val checkCapacityList = filteredChat.filter { it.attachment?.contains(outerIt.usage)?:false }
                if(checkCapacityList.size >= num)
                    limitedList.addAll(checkCapacityList.subList(0,num))
            }
            filteredChat=limitedList
        }
        setData(filteredChat)
    }

    fun setData(newChatList: List<Chat>){
        val diffUtil = ChatDiffUtil(chats,newChatList)
        val diffResults = DiffUtil.calculateDiff(diffUtil)
        chats = newChatList
        diffResults.dispatchUpdatesTo(this)
    }
}