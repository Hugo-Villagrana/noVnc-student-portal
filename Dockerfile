FROM debian:buster 
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
	default-jre \
	gcc \
	make \
	vim \
	less \
	openbox \
	ssh \
	rsync \
	wget \
	x11vnc \
	xvfb \
	websockify \
	novnc \   
	&& apt-get clean

RUN mkdir -p /logisim
WORKDIR /logisim
RUN wget https://iweb.dl.sourceforge.net/project/circuit/2.7.x/2.7.1/logisim-generic-2.7.1.jar

COPY startup.sh /usr/local/bin/.
COPY logisim.sh /usr/local/bin/.

RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user

RUN mkdir -p /home/user/.config/openbox
COPY autostart /home/user/.config/openbox/.

RUN mkdir /home/user/work

# Start the novnc server using the command
# websockify -D --web=/usr/share/novnc/ 80 localhost:5900 &&
# Type "localhost:5900" in browser
CMD websockify -D --web=/usr/share/novnc/ 80 localhost:5900 &&  /usr/local/bin/startup.sh
