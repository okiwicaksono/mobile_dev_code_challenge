package id.niteroomcreation.code.domain.di;

import android.content.Context;

import java.util.concurrent.Executor;

import id.niteroomcreation.code.KoinApplication;
import id.niteroomcreation.code.data.datasource.remote.RemoteDataSource;
import id.niteroomcreation.code.data.repo.Repository;
import id.niteroomcreation.code.data.repo.RepositoryImpl;
import id.niteroomcreation.code.util.AppExecutor;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class Injector {

    public static Repository provideRepository(Context context){
        AppExecutor executor = new AppExecutor();
        RemoteDataSource remoteDataSource = RemoteDataSource.getInstance(context, executor);

        return Repository.getInstance(context
                , remoteDataSource
                , executor);
    }

    public static Executor provideExecutor() {
        return new Executor() {
            @Override
            public void execute(Runnable runnable) {
                new Thread(runnable).start();
            }
        };
    }

    public static Context provideAppContext() {
        return KoinApplication.getContext();
    }
}
