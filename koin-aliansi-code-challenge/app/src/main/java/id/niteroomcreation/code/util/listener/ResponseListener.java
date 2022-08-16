package id.niteroomcreation.code.util.listener;

/**
 * Created by Septian Adi Wijaya on 23/12/2021.
 * please be sure to add credential if you use people's code
 */
public interface ResponseListener<T> {

    default void onLoading(){

    }

    void onResponse(T response);

    void onFailure(String message);
}
