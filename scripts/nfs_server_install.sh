# Unfortunately we won't actually automate a lot of this. 
# You can find the full steps here:
# https://www.tecmint.com/install-nfs-server-on-ubuntu/

# Step 1 - install nfs-server
sudo apt update
sudo apt install nfs-kernel-server

# Step 2 - NFS export directory
sudo mkdir -p /mnt/nfs_share
sudo chown -R nobody:nogroup /mnt/nfs_share
sudo chmod 777 /mnt/nfs_share

echo Job done for now.
echo Do not forget to configure share access manually.
