package id.niteroomcreation.code.util;

import android.os.Handler;
import android.os.Looper;

import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class AppExecutor {

    public static final String TAG = AppExecutor.class.getSimpleName();
    public static final int THREAD_COUNT = 3;
    private static AppExecutor INSTANCE;

    private Executor diskIO;
    private Executor mainThread;
    private Executor networkIO;

    private AppExecutor(Executor diskIO, Executor mainThread, Executor networkIO) {
        this.diskIO = diskIO;
        this.mainThread = mainThread;
        this.networkIO = networkIO;
    }

    public AppExecutor() {
        this(Executors.newSingleThreadExecutor()
                , new MainThreadExecutor()
                , Executors.newFixedThreadPool(THREAD_COUNT));
    }

    public static AppExecutor getInstance() {
        if (INSTANCE == null) {
            synchronized (AppExecutor.class) {
                INSTANCE = new AppExecutor(Executors.newSingleThreadExecutor()
                        , new MainThreadExecutor()
                        , Executors.newFixedThreadPool(THREAD_COUNT));
            }
        }
        return INSTANCE;
    }

    public Executor diskIO() {
        return diskIO;
    }

    public Executor networkIO() {
        return networkIO;
    }

    public Executor mainThread() {
        return mainThread;
    }

    private static class MainThreadExecutor implements Executor {

        public static final String TAG = MainThreadExecutor.class.getSimpleName();
        private Handler mainHandler = new Handler(Looper.getMainLooper());

        @Override
        public void execute(Runnable command) {
            mainHandler.post(command);
        }
    }
}