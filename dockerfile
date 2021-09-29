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