# 2.-dockerfile-backend-codeigniter

Membuat Images "codeigniter" dengan dockerfiles yang di anut dari registry/repsoitori bitnami:codeiniter

#### 1. Membuat command pada dockerfiles sebagai referensi images.

```
FROM   bitnami/codeigniter:3.1.11-debian-10-r569
RUN apt update -y
RUN apt upgrade -y
#install apt-get method
RUN apt install -y apt-utils
#install git
RUN apt-get install -y git
#install nano di dalam container
RUN apt-get install -y nano
#copy host folder kedalam container setup folder
COPY www/ /app
#aktiffkan session untuk sessions library  codeigniter pada php.ini
RUN echo "session.save_path=\"/tmp\"" >> /opt/bitnami/php/lib/php.ini

```

#### 2. build dockerfile agar dijadikan sebuah images dengan dependency versi kita sendiri

berikut perintah untuk buildimages (ditulis pada cmd/terminal di dalam folder yang sama dengan dockerfile)

!! pastikan aplikasi docker (docker daemon dalam keadaan running)

```
docker build . --tag newimagesname:tag(1.1-tes)

```

##### 3. Setelah images custome berhasil kita dibuat, selanjutnya kita coba membuat container baru untuk menguji images yang baru dibuat.

```
docker run

```

#### 4. Upload images yang sudah dibuat ke dalam dockerhub agar dapat digunakan kembali nanti

```
docker tag namaimageslocal:tag newreponame:tag
docker login -u dockeracckount
docker push newreponame:tag
```
