import torch
from torch import nn
# Filter all warnings to display less
import warnings
warnings.filterwarnings('ignore')


# define the network architecture
class net_pred(nn.Module):
    def __init__(self):
        super(net_pred, self).__init__()
        self.conv1 = nn.Conv3d(in_channels=1, out_channels=32, kernel_size=3, stride=1, bias=True)
        self.conv2 = nn.Conv3d(in_channels=32, out_channels=64, kernel_size=3, stride=1, bias=True)
        self.conv3 = nn.Conv3d(in_channels=64, out_channels=128, kernel_size=3, stride=1, bias=True)
        self.Pool_en = nn.AvgPool3d(4)

        self.drop_fc = nn.Dropout(0.5)
        self.activ = nn.Sigmoid()
        self.activ_pred = nn.ReLU()

        self.bn1 = nn.BatchNorm1d(32)
        self.bn2 = nn.BatchNorm1d(32)

        self.surv_pred1 = nn.Linear(128, 32)
        self.surv_pred2 = nn.Linear(32, 32)
        self.surv_pred3 = nn.Linear(32, 1, bias=False)

        self.drop_conv = nn.Dropout3d(0.5)
        self.drop_fc = nn.Dropout(0.5)
        self.Pool = nn.MaxPool3d(3)
        self.activ = nn.Sigmoid()

        self.bn1_conv = nn.BatchNorm3d(32)
        self.bn2_conv = nn.BatchNorm3d(64)
        self.bn3_conv = nn.BatchNorm3d(128)

    def forward(self, x):
        x = self.bn1_conv(self.drop_conv(self.activ(self.conv1(x.unsqueeze(1)))))
        x = self.bn2_conv(self.drop_conv(self.Pool(self.activ(self.conv2(x)))))
        x = self.bn3_conv(self.drop_conv(self.Pool(self.activ(self.conv3(x)))))
        x_en = self.Pool_en(x).squeeze()
        x = x_en.view(x.shape[0], -1)
        x = self.bn1(self.activ(self.surv_pred1(x)))
        x = self.bn2(self.activ(self.surv_pred2(x)))
        x = self.activ_pred(self.surv_pred3(x))
        return x, x_en


