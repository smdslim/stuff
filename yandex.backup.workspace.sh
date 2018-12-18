# Archive workspace to temp folder
echo "Making archive"
notify-send 'Workspace backup: making archive'
cd /media/smdslim/SECONDARY/Temp
# -FS to rewrite archive data
zip -q -FSr Workspace.zip /home/smdslim/Workspace

echo "Uploading archive"
notify-send 'Workspace backup: uploading archive to Yandex.Disk'

# Get upload link (OAuth key work 1 year - generated on 17.12.2018)
url=$( curl -s -H "Authorization: OAuth AQAAAAAAp-U9AAVava7Wl90rPUn0ln9kDyhywA8" 'https://cloud-api.yandex.net/v1/disk/resources/upload?path=/Documents/Workspace.zip&overwrite=true' | python3 -c "import sys, json; print(json.load(sys.stdin)['href'])")

curl -s "$url" --upload-file /media/smdslim/SECONDARY/Temp/Workspace.zip

echo "Archive uploaded!"
notify-send 'Workspace backup: archive uploaded'

# Go back to initial folder
cd -