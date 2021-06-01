package com.widyweili.atmatechchat.chatfeature.adapters

import android.app.DatePickerDialog
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.DatePicker
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.widyweili.atmatechchat.MainActivity
import com.widyweili.atmatechchat.chatfeature.v.ChatFragment
import com.widyweili.atmatechchat.databinding.*
import com.widyweili.atmatechchat.utilities.searchByTag
import com.widyweili.atmatechchat.chatfeature.m.Filter
import com.widyweili.atmatechchat.chatfeature.v.DatePickerDialogFragment
import com.widyweili.atmatechchat.chatfeature.vm.ChatViewModel
import java.util.*

class FilterAdapter(private val viewModel: ChatViewModel) : RecyclerView.Adapter<FilterAdapter.FilterChatViewHolder>() {

    private lateinit var fragInstance: ChatFragment
    private var filters = emptyList<Filter>()

    inner class FilterChatViewHolder(val binding: CardviewFilterBinding) : RecyclerView.ViewHolder(binding.root) {
        init {
            binding.checkBtnGroup.setOnClickListener {
                val edited= filters[bindingAdapterPosition]
                val checkBtn = binding.checkBtn
                if(checkBtn.visibility==View.GONE){
                    checkBtn.visibility = View.VISIBLE
                    edited.flag = true
                    viewModel.updateFilter(edited)
                    filters[bindingAdapterPosition].flag = edited.flag
                    checkSameDayFlag(edited.filterTitle,checkBtn.visibility)

                    return@setOnClickListener
                }

                checkBtn.visibility = View.GONE
                edited.flag = false
                viewModel.updateFilter(edited)
                filters[bindingAdapterPosition].flag = edited.flag
                checkSameDayFlag(edited.filterTitle,checkBtn.visibility)
            }
        }

        private fun checkSameDayFlag(filterTitle: String, uiVisibility: Int){
            if(filterTitle=="Same Day" && uiVisibility == View.VISIBLE){
                val listener = DatePickerDialog.OnDateSetListener { _, year, month, dayOfMonth ->
                    val c = Calendar.getInstance()
                    c.set(Calendar.YEAR,year)
                    c.set(Calendar.MONTH,month)
                    c.set(Calendar.DAY_OF_MONTH,dayOfMonth)

                    // start timestamp
                    c.set(Calendar.HOUR_OF_DAY,0)
                    val start = c.time
                    // end timestamp
                    c.set(Calendar.HOUR_OF_DAY,23)
                    val end = c.time
                    val filteredChatList = viewModel.getChats().filter { it.timestamp.time >= start.time && it.timestamp.time <= end.time }
                    Log.d("check-listener","$start - $end")
                    filteredChatList.forEach{
                        it.startSearchTs = start.time
                        it.endSearchTs = end.time
                        viewModel.updateChat(it)
                    }
                }
                val datePicker = DatePickerDialogFragment(listener)
                datePicker.showNow(fragInstance.parentFragmentManager,"date picker")
            }
            else if(filterTitle=="Same Day" && uiVisibility==View.GONE){
                viewModel.getChats().forEach {
                    it.startSearchTs = 0L
                    it.endSearchTs = 0L
                    viewModel.updateChat(it)
                }
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FilterChatViewHolder {
        val v = CardviewFilterBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return FilterChatViewHolder(v)
    }

    override fun getItemCount(): Int {
        return filters.size
    }

    override fun onBindViewHolder(holder: FilterChatViewHolder, position: Int) {
        val currentFilter = filters[position]
        holder.binding.filterTitle.text = currentFilter.filterTitle
        holder.binding.checkBtn.visibility = if(currentFilter.flag) View.VISIBLE else View.GONE
    }

    override fun onAttachedToRecyclerView(recyclerView: RecyclerView) {
        super.onAttachedToRecyclerView(recyclerView)
        val act = recyclerView.context as MainActivity
        fragInstance = act.supportFragmentManager.fragments.searchByTag("ChatFragment") as ChatFragment
    }

    fun setData(newFilters: List<Filter>){
        val diffUtil = FilterDiffUtill(filters,newFilters)
        val diffResults = DiffUtil.calculateDiff(diffUtil)
        filters = newFilters
        diffResults.dispatchUpdatesTo(this)
    }
}