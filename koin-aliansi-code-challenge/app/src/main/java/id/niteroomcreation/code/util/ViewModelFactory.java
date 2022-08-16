package id.niteroomcreation.code.util;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.lifecycle.ViewModel;
import androidx.lifecycle.ViewModelProvider;

import id.niteroomcreation.code.data.repo.Repository;
import id.niteroomcreation.code.domain.di.Injector;
import id.niteroomcreation.code.domain.interactor.MainUseCase;
import id.niteroomcreation.code.presentation.feature.main.MainViewModel;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class ViewModelFactory extends ViewModelProvider.NewInstanceFactory {

    private static volatile ViewModelFactory INSTANCE;

    private final Repository repository;

    private ViewModelFactory(Repository repository) {
        this.repository = repository;
    }

    public static ViewModelFactory getInstance(Context context) {
        if (INSTANCE == null) {
            synchronized (ViewModelFactory.class) {
                INSTANCE = new ViewModelFactory(Injector.provideRepository(context));
            }
        }
        return INSTANCE;
    }

    @NonNull
    @Override
    public <T extends ViewModel> T create(@NonNull Class<T> modelClass) {

        if (modelClass.isAssignableFrom(MainViewModel.class))
            return (T) new MainViewModel(new MainUseCase(repository));

        throw new IllegalArgumentException("Unknown ViewModel class " + modelClass.getName());
    }
}
