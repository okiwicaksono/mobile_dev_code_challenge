package com.anangsw.chatappschallenge.di

import com.anangsw.chatappschallenge.main.MainActivity
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class UIBinder {

    @ContributesAndroidInjector
    abstract fun contributeMainActivity(): MainActivity

}