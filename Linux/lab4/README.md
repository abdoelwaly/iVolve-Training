# Lab 4: Disk Management and Logical Volume Setup

## Objective
Attach a 15GB disk to your VM, make 4 partitions from this disk 4GB, 2GB, 6GB, and 3GB. Use the 4GB partition as a file system, configure the 2GB partition as swap, Initialize the second 5GB as a Volume Group (VG) with a Logical Volume (LV), then extend the LV by
adding the last 3GB partition.

## Partition Layout
The disk `/dev/xvdb` is partitioned as follows:

| Partition  | Size | Usage        |
|------------|------|--------------|
| `/dev/xvdb1` | 4GB  | Mounted as `/mnt/data` |
| `/dev/xvdb2` | 2GB  | Swap space   |
| `/dev/xvdb3` | 6GB  | Volume Group (`ivolve`) |
| `/dev/xvdb4` | 3GB  | Added to Volume Group (`ivolve`) |

---

## Steps
### 1. Format and Mount the 4GB Partition (`/dev/xvdb1`)
```bash
sudo mkfs.ext4 /dev/xvdb1
sudo mkdir -p /mnt/data
sudo mount /dev/xvdb1 /mnt/data
```
To persist the mount after reboot:
```bash
echo "/dev/xvdb1 /mnt/data ext4 defaults 0 0" | sudo tee -a /etc/fstab
```

### 2. Configure the 2GB Partition (`/dev/xvdb2`) as Swap
```bash
sudo mkswap /dev/xvdb2
sudo swapon /dev/xvdb2
```
Make it permanent:
```bash
echo "/dev/xvdb2 none swap sw 0 0" | sudo tee -a /etc/fstab
```

### 3. Create a Volume Group (`ivolve`) and Logical Volume (`ivolve-lg`)
```bash
sudo pvcreate /dev/xvdb3
sudo vgcreate ivolve /dev/xvdb3
sudo lvcreate -L 5G -n ivolve-lg ivolve
```
Format and mount the Logical Volume:
```bash
sudo mkfs.ext4 /dev/ivolve/ivolve-lg
sudo mkdir -p /mnt/lvdata
sudo mount /dev/ivolve/ivolve-lg /mnt/lvdata
```
Make it persistent:
```bash
echo "/dev/ivolve/ivolve-lg /mnt/lvdata ext4 defaults 0 0" | sudo tee -a /etc/fstab
```

### 4. Extend the Logical Volume (`ivolve-lg`) with the 3GB Partition (`/dev/xvdb4`)
```bash
sudo pvcreate /dev/xvdb4
sudo vgextend ivolve /dev/xvdb4
sudo lvextend -L +3G /dev/ivolve/ivolve-lg
sudo resize2fs /dev/ivolve/ivolve-lg
```

---

## Verification
Run the following commands to verify the setup:
```bash
lsblk
df -h
swapon --summary
vgdisplay
lvdisplay
```
