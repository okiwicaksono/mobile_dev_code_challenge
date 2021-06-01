package com.widyweili.atmatechchat.chatfeature.v

import android.graphics.Color
import android.os.Bundle
import android.util.Log
import android.view.*
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.LinearLayout
import androidx.core.graphics.drawable.DrawableCompat
import androidx.fragment.app.Fragment

import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.widyweili.atmatechchat.chatfeature.adapters.ChatListAdapter
import com.widyweili.atmatechchat.chatfeature.adapters.FilterAdapter
import com.widyweili.atmatechchat.databinding.ChatFragmentBinding
import com.widyweili.atmatechchat.chatfeature.vmf.ChatViewModelFactory
import com.widyweili.atmatechchat.chatfeature.vm.ChatViewModel
import com.widyweili.atmatechchat.chatfeature.db.ChatDatabase
import com.widyweili.atmatechchat.chatfeature.db.FilterDatabase
import com.widyweili.atmatechchat.chatfeature.repo.ChatRepository
import com.widyweili.atmatechchat.chatfeature.repo.FilterRepository
import com.widyweili.atmatechchat.R

class ChatFragment : Fragment() {

    private var _binding: ChatFragmentBinding? = null
    private val binding get() = _binding!!
    private lateinit var newFactory: ChatViewModelFactory
    private val newViewModel: ChatViewModel by viewModels(factoryProducer = {newFactory})

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = ChatFragmentBinding.inflate(inflater,container,false)
        return binding.root
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val dbInstance = ChatDatabase.getInstance()
        dbInstance.injectJsonData(requireActivity())
        val daoController = dbInstance.daoController
        val repoRef = ChatRepository.getInstance(daoController)
        val daoContoller2 = FilterDatabase.getInstance().daoController
        val filterRepoRef = FilterRepository.getInstance(daoContoller2)
        newFactory = ChatViewModelFactory(repoRef,filterRepoRef)
        // dont forget to observe the data from viewmodel

        val chatListSorted = newViewModel.getChats().sortedBy { it.timestamp.time }
        val chatAdapter = ChatListAdapter(newViewModel)
        chatAdapter.setData(chatListSorted)
        chatAdapter.generateRandomData()
        chatAdapter.recalculateDates()
        chatAdapter.checkYesterday()
        binding.chatList.layoutManager = LinearLayoutManager(context)
        binding.chatList.adapter = chatAdapter

        val filterAdapter1 = FilterAdapter(newViewModel)
        val filteredList = newViewModel.getFilters().filter{it.filterTitle=="Image" || it.filterTitle=="Contact"}
        filterAdapter1.setData(filteredList)
        binding.filterChoice.layoutManager = LinearLayoutManager(requireContext())
        binding.filterChoice.adapter = filterAdapter1

        val filterAdapter2 = FilterAdapter(newViewModel)
        binding.additionalFilterChoice.layoutManager = LinearLayoutManager(requireContext())
        binding.additionalFilterChoice.adapter = filterAdapter2

        binding.filterMsgBtn.setOnClickListener{controlLinearLayoutVisibility(binding.filterChoiceGroup)}
        binding.additionalFilterMsgBtn.setOnClickListener {
            if(binding.showInfoFilter.text=="None")
                return@setOnClickListener
            controlLinearLayoutVisibility(binding.additionalFilterChoiceGroup)
        }
        binding.filterChoiceApplyBtn.setOnClickListener {
            val filters = newViewModel.getFilters()
            val showInfoFilter = binding.showInfoFilter
            showInfoFilter.text = filters[0].filterTitle
            var finalFilter = ""
            filters.forEach {
                if((it.filterTitle=="Image" || it.filterTitle=="Contact") && it.flag)
                    finalFilter += "${it.filterTitle},"
            }
            finalFilter = finalFilter.trimEnd { c->c==',' }
            if(finalFilter==""){
                showInfoFilter.text = filters[0].filterTitle
                binding.showInfoAdditionalFilter.text = filters[0].filterTitle
                newViewModel.resetFilterData()
            }else
                showInfoFilter.text = finalFilter
            val filterResult = showInfoFilter.text
            if(filterResult.contains("Image,Contact") || filterResult.contains("Contact,Image")){
                val filteredList4 = newViewModel.getFilters().filter{(it.filterTitle != "Image" && it.filterTitle != "Contact") && (it.usage.contains("image") || it.usage.contains("contact"))}
                filterAdapter2.setData(filteredList4)
            }
            else if(filterResult.contains("Image")){
                val filteredList2 = newViewModel.getFilters().filter{(it.filterTitle != "Image" && it.filterTitle != "Contact") && it.usage.contains("image")}
                filterAdapter2.setData(filteredList2)
            }else if(filterResult.contains("Contact")){
                val filteredList3 = newViewModel.getFilters().filter{(it.filterTitle != "Image" && it.filterTitle != "Contact") && it.usage.contains("contact")}
                filterAdapter2.setData(filteredList3)
            }else{
                // none part
                filterAdapter2.setData(emptyList())
            }
            controlLinearLayoutVisibility(binding.filterChoiceGroup)
            chatAdapter.changeDataBasedOnFilter()
        }
        binding.additionalFilterChoiceApplyBtn.setOnClickListener{
            val filters = newViewModel.getFilters()
            val addShowInfoFilter = binding.showInfoAdditionalFilter
            addShowInfoFilter.text = filters[0].filterTitle
            var finalFilter = ""
            filters.forEach {
                if((it.filterTitle=="Same Day" ||
                                it.filterTitle=="Same Sender" ||
                                it.filterTitle=="No Title" ||
                                it.filterTitle=="Repeated 4 times" ||
                                it.filterTitle=="Repeated 2 times") && it.flag)
                    finalFilter += "${it.filterTitle},"
            }
            finalFilter = finalFilter.trimEnd { c->c==',' }
            val firstCommaOccurance = finalFilter.indexOf(",")
            val secondCommaOccurance = finalFilter.indexOf(",",firstCommaOccurance+1)
            val thirdCommaOccurance = finalFilter.indexOf(",",secondCommaOccurance+1)
            if(thirdCommaOccurance != -1){
                val subsFinalFilter1 = finalFilter.subSequence(0,secondCommaOccurance+1)
                val subsFinalFilter2 = "\n${finalFilter.substring(secondCommaOccurance+1,thirdCommaOccurance+1)}"
                val subsFinalFilter3 = "\n${finalFilter.substring(thirdCommaOccurance+1,finalFilter.length)}"
                finalFilter = "$subsFinalFilter1$subsFinalFilter2$subsFinalFilter3"
            }
            else if(secondCommaOccurance != -1){
                val subsFinalFilter1 = finalFilter.subSequence(0,secondCommaOccurance+1)
                val subsFinalFilter2 = "\n${finalFilter.substring(secondCommaOccurance+1,finalFilter.length)}"
                finalFilter = "$subsFinalFilter1$subsFinalFilter2"
            }
            addShowInfoFilter.text = if(finalFilter=="") filters[0].filterTitle else finalFilter
            controlLinearLayoutVisibility(binding.additionalFilterChoiceGroup)
            chatAdapter.changeDataBasedOnFilter()
        }

        val spinnerItemSelectedListener = object: AdapterView.OnItemSelectedListener{
            override fun onItemSelected(
                    parent: AdapterView<*>?,
                    view: View?,
                    position: Int,
                    id: Long
            ) {
                val user = parent!!.getItemAtPosition(position).toString()
                chatAdapter.currentUser=user
                val reverseUser = if(user=="A") "B" else "A"
                binding.nameHolder.text=reverseUser
                binding.ppChanger.text=reverseUser
                var drawableChanger = binding.ppChanger.background
                drawableChanger = DrawableCompat.wrap(drawableChanger)
                if(reverseUser=="A"){
                    DrawableCompat.setTint(drawableChanger,Color.WHITE)
                    binding.ppChanger.setTextColor(Color.BLACK)
                }else{
                    DrawableCompat.setTint(drawableChanger,Color.BLACK)
                    binding.ppChanger.setTextColor(Color.WHITE)
                }
                binding.ppChanger.background =drawableChanger
            }
            override fun onNothingSelected(parent: AdapterView<*>?) {}
        }
        val senderSpinner = binding.sender
        val spinnerAdapter = ArrayAdapter.createFromResource(requireContext(),R.array.users, android.R.layout.simple_spinner_item)
        spinnerAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        senderSpinner.adapter = spinnerAdapter
        senderSpinner.onItemSelectedListener = spinnerItemSelectedListener
    }

    private fun controlLinearLayoutVisibility(ll: LinearLayout){ ll.visibility = if(ll.visibility==View.GONE) View.VISIBLE else View.GONE }
}