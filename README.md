### A Preview of Quick Box
[![Quick Box v2.0.5 Dashboard](https://raw.githubusercontent.com/JMSDOnline/quick-box-assets/master/assets/quickbox-dasboard-youtube-preview.png)](http://www.youtube.com/watch?v=F1344A6YPks)

## How to install
> This script is valid for current Quick Box installs only. Please visit the Quick Box repo for the full installation kit.

---

## NOTE:
It is highly recommended that if you are a few versions behind that you update per version at a time. You can view the release versions [HERE](https://raw.githubusercontent.com/JMSDOnline/quick-box-update/master/releases). To apply a previous update, simply adjust the '**v2.0.7.tar.gz**' in the install command below with the version you need to bump to.

### Update for Quick Box on Ubuntu 14.04, 15.04, and 15.10 - Debian 7 and 8

**Run the following command to grab our prep script and setup for install ...**
```
wget -qO quickbox.tar.gz https://github.com/JMSDOnline/quick-box-update/archive/v2.0.7.tar.gz; \
mkdir -p /root/tmp/update; tar -xf quickbox.tar.gz -C /root/tmp; rm quickbox*; cd /root/tmp/update/quick-box-update*; \
bash qbupdate.sh

```

---

####REMEMBER: You must be logged in as root to run this update.
