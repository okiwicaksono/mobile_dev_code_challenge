package id.niteroomcreation.code.presentation.feature.main;

import androidx.lifecycle.Observer;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import java.util.ArrayList;

import id.niteroomcreation.code.R;
import id.niteroomcreation.code.data.service.Resource;
import id.niteroomcreation.code.databinding.AMainBinding;
import id.niteroomcreation.code.domain.model.DataResponse;
import id.niteroomcreation.code.presentation.base.BaseActivity;
import id.niteroomcreation.code.util.LogHelper;

/**
 * Created by Septian Adi Wijaya on 12/08/2022.
 * please be sure to add credential if you use people's code
 */
public class MainActivity
        extends BaseActivity<MainViewModel>
        implements MainViewModel.MainListener {

    public static final String TAG = MainActivity.class.getSimpleName();

    private AMainBinding binding;
    private MainAdapter adapter;

    @Override
    public void onCreateInside() {
        binding = AMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());
    }

    @Override
    public int contentLayout() {
        return R.layout.a_main;
    }

    @Override
    public void initUI() {

        binding.mainRvPull.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                mViewModel.getDataMessages();
            }
        });

        setupAdapter();
        setupObserver();
    }

    void setupAdapter() {
        adapter = new MainAdapter(new ArrayList<>());

        binding.mainRv.setLayoutManager(new LinearLayoutManager(this));
        binding.mainRv.setAdapter(adapter);
    }

    void setupObserver() {
        mViewModel = obtainViewModel(this, MainViewModel.class);
        mViewModel.setVmListener(this);

        mViewModel.getMessages().observe(this, new Observer<Resource<DataResponse>>() {
            @Override
            public void onChanged(Resource<DataResponse> data) {

                LogHelper.e(TAG, data);

                switch (data.status) {
                    case LOADING:
                        binding.mainRvPull.setRefreshing(true);
                        break;

                    case SUCCESS:
                        binding.mainRvPull.setRefreshing(false);

                        adapter.update(data.data.getData());
                        break;

                    case ERROR:
                        binding.mainRvPull.setRefreshing(false);

                        onErrorMessage(data.message);
                        break;
                }
            }
        });

        mViewModel.getDataMessages();
        binding.setVm(mViewModel);
    }

    @Override
    public void onErrorMessage(String message) {
        showMessage(message);
    }
}
