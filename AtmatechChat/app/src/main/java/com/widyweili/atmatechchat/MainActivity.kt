package com.widyweili.atmatechchat

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.widyweili.atmatechchat.databinding.ActivityMainBinding
import com.widyweili.atmatechchat.chatfeature.v.ChatFragment
import com.widyweili.atmatechchat.utilities.Constants

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                    .replace(Constants.FRAGMENT_CONTAINER,
                            ChatFragment(),"ChatFragment")
                    .commitNow()
        }
    }

}