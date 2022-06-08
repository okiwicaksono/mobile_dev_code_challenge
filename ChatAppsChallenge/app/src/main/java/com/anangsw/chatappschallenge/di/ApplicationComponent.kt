package com.anangsw.chatappschallenge.di

import android.content.Context
import com.anangsw.chatappschallenge.ChatApps
import dagger.BindsInstance
import dagger.Component
import dagger.android.AndroidInjectionModule
import dagger.android.AndroidInjector
import dagger.android.support.AndroidSupportInjectionModule
import javax.inject.Singleton

@Singleton
@Component(
    modules =[
        AndroidSupportInjectionModule::class,
        AndroidInjectionModule::class,
        AppModule::class,
        UIBinder::class
    ]
)
interface ApplicationComponent: AndroidInjector<ChatApps> {

    @Component.Factory
    interface Factory {
        fun create(@BindsInstance applicationContext: Context): ApplicationComponent
    }

}