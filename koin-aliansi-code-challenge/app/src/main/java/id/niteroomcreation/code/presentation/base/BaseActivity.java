package id.niteroomcreation.code.presentation.base;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;
import androidx.lifecycle.ViewModelStoreOwner;

import id.niteroomcreation.code.databinding.BActivityBinding;
import id.niteroomcreation.code.util.ViewModelFactory;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public abstract class BaseActivity<VM extends BaseViewModel>
        extends AppCompatActivity
        implements IBaseView {


    public static final String TAG = BaseActivity.class.getSimpleName();
    public static final int EMPTY_LAYOUT = 0;

    private Context context;
    private Toast mToast;
    private ProgressDialog progressLoading;
    protected VM mViewModel;

    private BActivityBinding binding;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = BActivityBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        context = this;
        progressLoading = new ProgressDialog(this);

        onCreateInside();
        initUI();

        if (contentLayout() != EMPTY_LAYOUT) {
            try {
                LayoutInflater inflater = (LayoutInflater) this.getSystemService(LAYOUT_INFLATER_SERVICE);
                inflater.inflate(contentLayout(), binding.layoutContent);
            } catch (Exception e) {
                throw new RuntimeException("Inflating contentLayout() failed on " + this.getClass().getSimpleName());
            }
        }
    }

    public VM obtainViewModel(ViewModelStoreOwner owner, Class<VM> vm) {
        return (VM) new ViewModelProvider(owner, ViewModelFactory.getInstance(getContext())).get(vm);
    }

    @Override
    public void showMessage(String message) {
        if (mToast != null) {
            mToast.cancel();
            mToast = null;
        }

        if (message != null && !message.isEmpty()) {
            mToast = Toast.makeText(this, message, Toast.LENGTH_LONG);
            mToast.show();
        }
    }

    @Override
    public void showProgressLoading(@Nullable String title, String desc) {
        progressLoading.setTitle(title == null ? "" : title);
        progressLoading.setMessage(desc);
        progressLoading.setCancelable(false);
        progressLoading.setCanceledOnTouchOutside(false);
        progressLoading.show();
    }

    @Override
    public void dismissProgressLoading() {
        if (progressLoading.isShowing())
            progressLoading.dismiss();
    }

    private Context getContext() {
        return this.context;
    }
}
