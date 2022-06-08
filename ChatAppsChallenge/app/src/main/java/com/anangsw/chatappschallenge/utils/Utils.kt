package com.anangsw.chatappschallenge.utils

import android.content.Context
import android.view.View
import android.widget.TextView
import androidx.core.content.ContextCompat
import com.anangsw.chatappschallenge.R
import com.google.android.material.snackbar.Snackbar

object Utils {

    fun showErrorSnackBar(context: Context, view: View, message: String) {
        val snackbar = Snackbar.make(view, message, Snackbar.LENGTH_LONG)
        val snackbarView = snackbar.view
        val tv = snackbarView.findViewById<TextView>(com.google.android.material.R.id.snackbar_text)
        tv.setTextColor(
            ContextCompat.getColor(context, R.color.snackerrortext)
        )
        snackbarView.setBackgroundColor(
            ContextCompat.getColor(context, R.color.snackerror)
        )
        snackbar.show()
    }

}