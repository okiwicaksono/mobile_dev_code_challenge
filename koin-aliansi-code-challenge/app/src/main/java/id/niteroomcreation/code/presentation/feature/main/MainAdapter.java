package id.niteroomcreation.code.presentation.feature.main;

import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import org.joda.time.DateTime;

import java.util.List;

import id.niteroomcreation.code.databinding.IMainBinding;
import id.niteroomcreation.code.domain.model.DataItem;
import id.niteroomcreation.code.util.CommonUtil;

/**
 * Created by Septian Adi Wijaya on 16/08/2022.
 * please be sure to add credential if you use people's code
 */
public class MainAdapter extends RecyclerView.Adapter<MainAdapter.ViewHolder> {

    public static final String TAG = MainAdapter.class.getSimpleName();

    private List<DataItem> data;

    public MainAdapter(List<DataItem> data) {
        this.data = data;
    }

    public void update(List<DataItem> data) {
        this.data = data;
        notifyDataSetChanged();
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        IMainBinding binding = IMainBinding.inflate(LayoutInflater.from(parent.getContext()), parent, false);
        return new ViewHolder(binding);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        holder.binds();
    }

    @Override
    public int getItemCount() {
        return data != null ? data.size() : 0;
    }

    public DataItem getItem(int pos) {
        return data.get(pos);
    }

    class ViewHolder extends RecyclerView.ViewHolder {

        private IMainBinding binding;

        public ViewHolder(@NonNull IMainBinding binding) {
            super(binding.getRoot());
            this.binding = binding;
        }

        void binds() {

            binding.itemMsgBody.setVisibility(getItem(getAdapterPosition()).getBody() != null ? View.VISIBLE : View.GONE);
            binding.itemMsgAttachmentLayout.setVisibility(getItem(getAdapterPosition()).getAttachment() != null ? View.VISIBLE : View.GONE);

            binding.itemMsgBody.setText(getItem(getAdapterPosition()).getBody());
            binding.itemMsgDate.setText(CommonUtil.dateToStringPattern(new DateTime(Long.parseLong(getItem(getAdapterPosition()).getTimestamp()) * 1000L).toDate()));
            binding.itemMsgAttachment.setText("This is " + getItem(getAdapterPosition()).getAttachment());


            binding.itemMsgBody.setGravity(getItem(getAdapterPosition()).getFrom().equals("A") ? Gravity.START : Gravity.END);
            binding.itemMsgDate.setGravity(getItem(getAdapterPosition()).getFrom().equals("A") ? Gravity.START : Gravity.END);
            binding.itemMsgAttachment.setGravity(getItem(getAdapterPosition()).getFrom().equals("A") ? Gravity.START : Gravity.END);
        }
    }
}
