package id.test.myapplication.ui.main

import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.gson.GsonBuilder
import id.test.myapplication.api.Resource
import id.test.myapplication.databinding.ActivityMainBinding
import id.test.myapplication.model.DataResponse
import id.test.myapplication.ui.adapter.RvChatAdapter
import id.test.myapplication.util.getViewModel


class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private val mainViewModel by lazy {
        getViewModel<MainViewModel>()
    }
    var rvChat : RecyclerView? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)
        rvChat = binding.rvChat
        mainViewModel.getDataResponse.observe(this,datagetObserver)
        mainViewModel.onDataGet()
    }

    private val datagetObserver =
        Observer<Resource<DataResponse>> { value -> value?.let {
            when (it.status) {
                Resource.Status.SUCCESS -> {
                    val data = it.data!!.data!!
                    val lm = LinearLayoutManager(this, RecyclerView.VERTICAL, false)
                    lm.isAutoMeasureEnabled = false
                    val adapter = RvChatAdapter(data,this@MainActivity)
                    binding.rvChat.layoutManager = lm
                    binding.rvChat.adapter = adapter
                }
                Resource.Status.ERROR -> {

                    val builder = AlertDialog.Builder(this)
                    builder.setTitle("Error")
                    builder.setMessage(it.error!!.message)
                    builder.setPositiveButton(android.R.string.ok) { dialog, which ->
                        Toast.makeText(applicationContext,
                            android.R.string.ok, Toast.LENGTH_SHORT).show()
                    }

                    builder.show()
                }
                Resource.Status.LOADING -> {
                }
            }
        } }
}