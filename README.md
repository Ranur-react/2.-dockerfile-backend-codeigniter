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
docker run -d -p 87:8000 --name newname imagesfrom

```

#### 4. Upload images yang sudah dibuat ke dalam dockerhub agar dapat digunakan kembali nanti

```
docker tag namaimageslocal:tag newreponame:tag
docker login -u dockeracckount
docker push newreponame:tag
```

#### 5. Stop container tes yang udah jalan dengna perintah berikut

```

docker stop newcontainername

```

#### 6. membuat lebih dari satu container automatis dengan docker-compose

###### a.

tulis scripting dibawah dengan nama files

"docker-compose.yml"

```
version: "3.7"
services:
    mariadb:
        image: docker.io/bitnami/mariadb:10.3
        environment:
            - MARIADB_ROOT_PASSWORD=barangmudo007
        ports:
            - 3306:3306
        networks:
            - databases
        volumes:
            - ./database/db_filebackupfromsqlyoq.sql:/docker-entrypoint-initdb.d/dump.sql
        container_name: mariadb
    phpmyadmin:
        image: ranur/phpmyadmin:1.1-links
        ports:
            - 85:80
        container_name: phpmyadmin
  web:
    image: ranur/ranur-codeigniter
    volumes:
      - ./dashboard-api/:/app/myapp
    ports:
      - 87:8000
    networks:
      - databases
    container_name: container-api
networks:
  databases:
    external: true

```

###### b. membuat netwrok baru sesuai dengan yang ditulis di commadn docker-compose

```
docker network local
```

###### c. jalankan files docker-compose sebagai orkestra unntuk menjalankan multiple container yang sudah di konfigurasi dengan docker-compose files

```
docker-compose up
```

perintah ini di jalankan di dalam folder yang sama dengan doker-compose.YML

### 7. container yang sudah berjalan sudah dapat digunakan
