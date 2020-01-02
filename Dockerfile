#Download base image python
FROM python:3.9.0a2-alpine3.10

# Update Software repository
RUN apk add git gcc g++ openssl make
RUN pip install Twisted

ARG PROTOCOL
ARG TARGET
ARG PORT
ARG ADD
ARG TIMEOUT
ARG TRUNCATE
ARG LOGID

RUN git clone https://gitlab.com/akihe/radamsa.git
RUN cd radamsa && make && make install

COPY . /fuzz
RUN sed 's/%PROTOCOL%/${PROTOCOL}/g; s/%TARGET%/${TARGET}/g; s/%PORT%/${PORT}/g; s/%ADD%/${ADD}/g; s/%TIMEOUT%/${TIMEOUT}/g; s/%TRUNCATE%/${TRUNCATE}/g; s/%LOGID%/${LOGID}/g;' /fuzz/entry.pt > /fuzz/entry.sh
RUN chmod +rwx /fuzz/entry.sh

CMD ["/bin/ash","/fuzz/entry.sh"]
