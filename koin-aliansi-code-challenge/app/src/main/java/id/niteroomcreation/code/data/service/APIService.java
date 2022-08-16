package id.niteroomcreation.code.data.service;

import android.content.Context;

import com.google.gson.GsonBuilder;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import id.niteroomcreation.code.BuildConfig;
import id.niteroomcreation.code.domain.di.Injector;
import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class APIService {

    private static RemoteAPI api;

    public static RemoteAPI createService(Context context) {
        HttpLoggingInterceptor httpLoggingInterceptor = new HttpLoggingInterceptor();
        //set logging level to NONE
        //so there is no log information while request
        //see: https://futurestud.io/blog/retrofit-2-log-requests-and-responses
        if (BuildConfig.DEBUG)
            httpLoggingInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY);
        else
            httpLoggingInterceptor.setLevel(HttpLoggingInterceptor.Level.NONE);

        OkHttpClient okHttpClient = new OkHttpClient.Builder()
                .retryOnConnectionFailure(true)
                .readTimeout(15, TimeUnit.SECONDS)
                .writeTimeout(15, TimeUnit.SECONDS)

//                .addInterceptor(Injector.provideNetworkInterceptor(Injector.provideAppContext()))
                .addInterceptor(httpLoggingInterceptor)
                .build();

        getApi(okHttpClient);

        return api;
    }

    private static void getApi(OkHttpClient okHttpClient) {
        GsonBuilder builder = new GsonBuilder();
        builder.excludeFieldsWithoutExposeAnnotation();

        if (api == null) {
            api = new Retrofit.Builder()
                    .baseUrl(BuildConfig.BASE_URL)
                    .addConverterFactory(GsonConverterFactory.create(builder.create()))
                    .client(okHttpClient)
                    .build()
                    .create(RemoteAPI.class);
        }

    }

    public static class NetworkInterceptor implements Interceptor {

        private static NetworkInterceptor instance;

        public NetworkInterceptor() {
        }

        public static NetworkInterceptor getInstance() {
            if (instance == null) {
                instance = new NetworkInterceptor();
            }
            return instance;
        }

        @Override
        public Response intercept(Chain chain) throws IOException {
            Request request = chain.request();


            if (BuildConfig.DEBUG) {

            }

            Request.Builder requestBuilder = request
                    .newBuilder()
                    .method(request.method(), request.body());

//                requestBuilder = requestBuilder
//                        .header("Authorization", "JWT " + subsToUse);

            return chain.proceed(requestBuilder.build());
        }
    }
}
