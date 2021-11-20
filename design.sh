#!/bin/bash

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp designproj.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python" > tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  designproj.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "RUN python3 -m pip install flask" >> tempdir/Dockerfile
echo "RUN python3 -m pip install urllib3" >> tempdir/Dockerfile
echo "RUN python3 -m pip install requests" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/designproj.py" >> tempdir/Dockerfile

cd tempdir
docker build -t designapp .
docker run -t -d -p 5050:5050 --name designapprunning designapp
docker ps -a