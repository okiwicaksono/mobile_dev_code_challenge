package com.widyweili.atmatechchat.utilities

import android.content.res.Resources
import androidx.fragment.app.Fragment

fun List<Fragment>.searchByTag(newTag: String): Fragment?{
    forEach {
        if(it.tag == newTag){
            return it
        }
    }
    return null
}

val Int.dp: Int get() = (this / Resources.getSystem().displayMetrics.density).toInt()
val Int.px: Int get() = (this * Resources.getSystem().displayMetrics.density).toInt()