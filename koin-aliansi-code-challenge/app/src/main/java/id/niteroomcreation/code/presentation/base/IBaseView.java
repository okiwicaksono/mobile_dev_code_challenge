package id.niteroomcreation.code.presentation.base;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.LayoutRes;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public interface IBaseView {

    default View onInflateView(@NonNull LayoutInflater inflater
            , @Nullable ViewGroup container
            , @Nullable Bundle savedInstanceState) {
        return null;
    }

    default void onCreateInside() {
    }

    default void destroyUI() {
    }

    void initUI();

    void showMessage(String msg);

    void showProgressLoading(String title, String desc);

    void dismissProgressLoading();

    @LayoutRes
    default int contentLayout() {
        return 0;
    }
}