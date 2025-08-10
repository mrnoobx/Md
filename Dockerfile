FROM node:lts-buster
USER root

# Fix sources.list to point to archive
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y ffmpeg libwebp-dev git && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

USER node
RUN git clone https://github.com/JawadTechX/DJ /home/node/DJ
WORKDIR /home/node/DJ
RUN chmod -R 777 /home/node/DJ/
RUN yarn install --network-concurrency 1

EXPOSE 7860
ENV NODE_ENV=production
CMD ["npm", "start"]
