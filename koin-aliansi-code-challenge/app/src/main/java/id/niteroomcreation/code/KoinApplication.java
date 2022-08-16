package id.niteroomcreation.code;

import android.content.Context;

import androidx.multidex.MultiDex;
import androidx.multidex.MultiDexApplication;

import net.danlew.android.joda.JodaTimeAndroid;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class KoinApplication extends MultiDexApplication {

    private  static KoinApplication instance;
    private static Context mContext;

    @Override
    public void onCreate() {
        super.onCreate();

        mContext = getApplicationContext();

        MultiDex.install(this);
        JodaTimeAndroid.init(this);
    }

    public static KoinApplication getInstance() {
        if (instance == null)
            synchronized (KoinApplication.class) {
                instance = new KoinApplication();
            }
        return instance;
    }

    public static Context getContext() {
        return mContext;
    }
}
