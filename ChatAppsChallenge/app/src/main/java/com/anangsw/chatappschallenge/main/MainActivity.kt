package com.anangsw.chatappschallenge.main

import android.os.Bundle
import androidx.activity.viewModels
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import com.anangsw.chatappschallenge.R
import com.anangsw.chatappschallenge.databinding.ActivityMainBinding
import com.anangsw.chatappschallenge.main.adapter.MessageRecyclerAdapter
import com.anangsw.chatappschallenge.utils.Utils
import com.anangsw.chatappschallenge.utils.ViewModelFactory
import com.anangsw.chatappschallenge.utils.observe
import dagger.android.support.DaggerAppCompatActivity
import javax.inject.Inject

class MainActivity : DaggerAppCompatActivity() {

    @Inject
    lateinit var factory: ViewModelFactory<MainViewModel>
    private val viewModel: MainViewModel by viewModels { factory }

    private lateinit var viewBinding: ActivityMainBinding
    private lateinit var adapter: MessageRecyclerAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewBinding = DataBindingUtil.setContentView(this, R.layout.activity_main)
        viewBinding.executePendingBindings()
        viewModel.getMessages()
        viewBinding.swipeRefresh.isRefreshing = true
        observe(viewModel.state, ::onViewStateChanged)
        onViewBindingEvents()
        setupAdapter()
    }

    private fun setupAdapter() {
        adapter = MessageRecyclerAdapter()
        viewBinding.rvMessages.layoutManager = LinearLayoutManager(this)
        viewBinding.rvMessages.adapter = adapter
    }

    private fun onViewBindingEvents() {
        viewBinding.swipeRefresh.setOnRefreshListener {
            viewModel.getMessages()
        }
    }

    private fun onViewStateChanged(state: MainViewState) {
        when (state) {
            is MainViewState.GetMessagesSuccess -> {
                viewBinding.swipeRefresh.isRefreshing = false
                adapter.submitList(state.messages)
            }
            is MainViewState.GetMessagesFailed -> {
                Utils.showErrorSnackBar(this, viewBinding.root, state.msg)
                viewBinding.swipeRefresh.isRefreshing = false
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        viewBinding.unbind()
    }
}