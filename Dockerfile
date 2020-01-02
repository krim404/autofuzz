#Download base image python
FROM python:2.7.15-alpine3.9

# Update Software repository
RUN apk add git gcc g++ openssl make
RUN pip install Twisted

ARG TARGET
ARG PORT
ARG ADD
ARG TIMEOUT
ARG TRUNCATE
ARG LOGID

RUN git clone https://gitlab.com/akihe/radamsa.git
RUN cd radamsa && make && make install

RUN sed 's/%TARGET%/${TARGET}/g; s/%PORT%/${PORT}/g; s/%ADD%/${ADD}/g; s/%TIMEOUT%/${TIMEOUT}/g; s/%TRUNCATE%/${TRUNCATE}/g; s/%LOGID%/${LOGID}/g;' entry.pt > ./entry.sh
RUN chmod +rwx ./entry.sh

CMD ["/bin/ash","./entry.sh"]
